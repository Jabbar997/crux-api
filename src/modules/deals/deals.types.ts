import { DealStatus } from '@prisma/client';

export interface CreateDealDTO {
    title: string;
    description?: string;
    imageUrl?: string;
    materialType?: string; // Optional, might be used for filtering or filtering suppliers
    supplierId: string;
    targetQuantity: number;
    pricePerUnit: number;
    startDate: Date | string;
    endDate: Date | string;
    autoExtend?: boolean;
}

export enum DealPhase {
    FUTURE = 'FUTURE',
    ACTIVE = 'ACTIVE',
    EXTENDED = 'EXTENDED',
    COMPLETED = 'COMPLETED',
    CANCELLED = 'CANCELLED',
}

export interface DealResolutionResult {
    newStatus: DealStatus;
    newEndDate?: Date;
    message: string;
}
