import { PrismaClient, Deal, DealStatus, OrderStatus } from '@prisma/client';
import { CreateDealDTO, DealResolutionResult } from './deals.types.js';
import { calculateCompletionPercent, resolveDealStatus } from './deals.logic.js';

const prisma = new PrismaClient();

export class DealsService {
    async getFutureDeals() {
        return await prisma.deal.findMany({
            where: { status: DealStatus.FUTURE },
            include: { supplier: true },
        });
    }

    async getActiveDeals() {
        return await prisma.deal.findMany({
            where: {
                status: {
                    in: [DealStatus.ACTIVE, DealStatus.EXTENDED],
                },
            },
            include: { supplier: true },
        });
    }

    async getCompletedDeals() {
        return await prisma.deal.findMany({
            where: { status: DealStatus.COMPLETED },
            include: { supplier: true },
        });
    }

    async getDealById(id: string) {
        const deal = await prisma.deal.findUnique({
            where: { id },
            include: { supplier: true },
        });
        if (!deal) throw new Error('Deal not found');
        return deal;
    }

    async createDeal(dto: CreateDealDTO) {
        return await prisma.deal.create({
            data: {
                title: dto.title,
                description: dto.description,
                imageUrl: dto.imageUrl,
                price: dto.pricePerUnit,
                targetQuantity: dto.targetQuantity,
                currentQuantity: 0,
                startDate: new Date(dto.startDate),
                endDate: new Date(dto.endDate),
                status: DealStatus.FUTURE,
                autoExtend: dto.autoExtend ?? true,
                supplierId: dto.supplierId,
            },
        });
    }

    async recalculateDealProgress(dealId: string): Promise<number> {
        const aggregate = await prisma.order.aggregate({
            _sum: {
                quantity: true,
            },
            where: {
                dealId,
                status: {
                    not: OrderStatus.CANCELLED,
                },
            },
        });

        const totalQuantity = aggregate._sum.quantity || 0;

        const deal = await prisma.deal.findUnique({ where: { id: dealId } });
        if (!deal) throw new Error('Deal not found');

        await prisma.deal.update({
            where: { id: dealId },
            data: { currentQuantity: totalQuantity },
        });

        return calculateCompletionPercent(totalQuantity, deal.targetQuantity);
    }

    async resolveDeal(dealId: string) {
        const deal = await prisma.deal.findUnique({ where: { id: dealId } });
        if (!deal) throw new Error('Deal not found');

        const completionPercent = await this.recalculateDealProgress(dealId);
        const now = new Date();

        // Determine if it has been extended. 
        // We can check if status is EXTENDED.
        const hasBeenExtended = deal.status === DealStatus.EXTENDED;

        const resolution: DealResolutionResult = resolveDealStatus({
            status: deal.status,
            completionPercent,
            autoExtend: deal.autoExtend,
            hasBeenExtended,
            now,
            endDate: deal.endDate,
        });

        if (resolution.newStatus !== deal.status || resolution.newEndDate) {
            const updatedDeal = await prisma.deal.update({
                where: { id: dealId },
                data: {
                    status: resolution.newStatus,
                    endDate: resolution.newEndDate || deal.endDate,
                },
            });
            return { deal: updatedDeal, resolution };
        }

        return { deal, resolution };
    }
}
