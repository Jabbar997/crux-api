import { PrismaClient, DealStatus, PaymentStatus } from '@prisma/client';
import { calculateCompletionPercent } from '../deals/deals.logic';

const prisma = new PrismaClient();

export class AdminService {
    async getSystemStats() {
        const now = new Date();
        const startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate());

        const [
            totalUsers,
            totalSuppliers,
            totalDeals,
            totalOrders,
            totalPayments,
            activeDeals,
            completedDeals,
            cancelledDeals,
            todayNewUsers,
            todayOrders,
            todayRevenueAggregate,
        ] = await Promise.all([
            prisma.user.count(),
            prisma.supplier.count(),
            prisma.deal.count(),
            prisma.order.count(),
            prisma.payment.count(),
            prisma.deal.count({ where: { status: { in: [DealStatus.ACTIVE, DealStatus.EXTENDED] } } }),
            prisma.deal.count({ where: { status: DealStatus.COMPLETED } }),
            prisma.deal.count({ where: { status: DealStatus.CANCELLED } }),
            prisma.user.count({ where: { createdAt: { gte: startOfDay } } }),
            prisma.order.count({ where: { createdAt: { gte: startOfDay } } }),
            prisma.payment.aggregate({
                _sum: { amount: true },
                where: {
                    status: PaymentStatus.PAID,
                    createdAt: { gte: startOfDay },
                },
            }),
        ]);

        return {
            totalUsers,
            totalSuppliers,
            totalDeals,
            totalOrders,
            totalPayments,
            activeDeals,
            completedDeals,
            cancelledDeals,
            todayNewUsers,
            todayOrders,
            todayRevenue: todayRevenueAggregate._sum.amount || 0,
        };
    }

    async getDashboardDeals() {
        const deals = await prisma.deal.findMany({
            orderBy: { createdAt: 'desc' },
            take: 20,
            include: { supplier: true },
        });

        return deals.map((deal) => ({
            ...deal,
            percentage: calculateCompletionPercent(deal.currentQuantity, deal.targetQuantity),
        }));
    }

    async getUsers() {
        const users = await prisma.user.findMany({
            select: {
                id: true,
                name: true,
                phone: true,
                createdAt: true,
                _count: {
                    select: { orders: true },
                },
            },
        });

        return users.map((user) => ({
            id: user.id,
            name: user.name,
            phone: user.phone,
            createdAt: user.createdAt,
            totalOrders: user._count.orders,
        }));
    }

    async getSuppliers() {
        const suppliers = await prisma.supplier.findMany({
            include: {
                _count: {
                    select: { deals: true },
                },
            },
        });

        return suppliers.map((supplier) => ({
            ...supplier,
            dealCount: supplier._count.deals,
        }));
    }

    async getOrders() {
        return await prisma.order.findMany({
            include: {
                user: {
                    select: { name: true, email: true, phone: true },
                },
                deal: {
                    select: { title: true },
                },
            },
            orderBy: { createdAt: 'desc' },
        });
    }
}
