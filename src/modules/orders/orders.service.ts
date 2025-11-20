import { PrismaClient, OrderStatus, DealStatus } from '@prisma/client';
import { CreateOrderDTO } from './orders.types';
import { DealsService } from '../deals/deals.service';

const prisma = new PrismaClient();
const dealsService = new DealsService();

export class OrdersService {
    async createOrder(dto: CreateOrderDTO) {
        const deal = await prisma.deal.findUnique({ where: { id: dto.dealId } });

        if (!deal) {
            throw new Error('Deal not found');
        }

        if (deal.status !== DealStatus.ACTIVE && deal.status !== DealStatus.EXTENDED) {
            throw new Error('Deal is not active');
        }

        const totalAmount = Number(deal.price) * dto.quantity;

        const order = await prisma.order.create({
            data: {
                userId: dto.userId,
                dealId: dto.dealId,
                quantity: dto.quantity,
                totalAmount,
                status: OrderStatus.PENDING,
            },
        });

        // Update deal progress
        await dealsService.recalculateDealProgress(dto.dealId);

        return order;
    }

    async confirmOrder(orderId: string) {
        const order = await prisma.order.findUnique({ where: { id: orderId } });
        if (!order) throw new Error('Order not found');

        const updatedOrder = await prisma.order.update({
            where: { id: orderId },
            data: { status: OrderStatus.CONFIRMED },
        });

        await dealsService.recalculateDealProgress(order.dealId);

        return updatedOrder;
    }

    async cancelOrder(orderId: string) {
        const order = await prisma.order.findUnique({ where: { id: orderId } });
        if (!order) throw new Error('Order not found');

        const updatedOrder = await prisma.order.update({
            where: { id: orderId },
            data: { status: OrderStatus.CANCELLED },
        });

        await dealsService.recalculateDealProgress(order.dealId);

        return updatedOrder;
    }

    async getOrdersByUser(userId: string) {
        return await prisma.order.findMany({
            where: { userId },
            include: { deal: true },
        });
    }

    async getOrdersByDeal(dealId: string) {
        return await prisma.order.findMany({
            where: { dealId },
            include: { user: true },
        });
    }
}
