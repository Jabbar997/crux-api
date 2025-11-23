import { PrismaClient, PaymentStatus, OrderStatus } from '@prisma/client';
import { CreatePaymentDTO } from './payments.types.js';
import { DealsService } from '../deals/deals.service.js';

const prisma = new PrismaClient();
const dealsService = new DealsService();

export class PaymentsService {
    async createPayment(dto: CreatePaymentDTO) {
        const order = await prisma.order.findUnique({ where: { id: dto.orderId } });

        if (!order) {
            throw new Error('Order not found');
        }

        if (order.status === OrderStatus.CANCELLED) {
            throw new Error('Cannot pay for a cancelled order');
        }

        // Check if payment already exists
        const existingPayment = await prisma.payment.findUnique({
            where: { orderId: dto.orderId },
        });

        if (existingPayment) {
            throw new Error('Payment already exists for this order');
        }

        return await prisma.payment.create({
            data: {
                orderId: dto.orderId,
                amount: dto.amount,
                status: PaymentStatus.PENDING,
            },
        });
    }

    async markPaymentAsPaid(paymentId: string) {
        const payment = await prisma.payment.findUnique({
            where: { id: paymentId },
            include: { order: true },
        });

        if (!payment) throw new Error('Payment not found');

        const updatedPayment = await prisma.payment.update({
            where: { id: paymentId },
            data: { status: PaymentStatus.PAID },
        });

        if (payment.order) {
            await prisma.order.update({
                where: { id: payment.orderId },
                data: { status: OrderStatus.CONFIRMED },
            });

            await dealsService.recalculateDealProgress(payment.order.dealId);
        }

        return updatedPayment;
    }

    async markPaymentAsFailed(paymentId: string) {
        const payment = await prisma.payment.findUnique({ where: { id: paymentId } });
        if (!payment) throw new Error('Payment not found');

        return await prisma.payment.update({
            where: { id: paymentId },
            data: { status: PaymentStatus.FAILED },
        });
    }

    async refundPayment(paymentId: string) {
        const payment = await prisma.payment.findUnique({
            where: { id: paymentId },
            include: { order: true },
        });

        if (!payment) throw new Error('Payment not found');

        const updatedPayment = await prisma.payment.update({
            where: { id: paymentId },
            data: { status: PaymentStatus.REFUNDED },
        });

        if (payment.order) {
            await prisma.order.update({
                where: { id: payment.orderId },
                data: { status: OrderStatus.CANCELLED },
            });

            await dealsService.recalculateDealProgress(payment.order.dealId);
        }

        return updatedPayment;
    }

    async getPaymentsByOrder(orderId: string) {
        return await prisma.payment.findMany({
            where: { orderId },
        });
    }
}
