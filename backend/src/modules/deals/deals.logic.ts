import { DealStatus } from '@prisma/client';
import { DealPhase, DealResolutionResult } from './deals.types.js';

export const calculateCompletionPercent = (currentQuantity: number, targetQuantity: number): number => {
    if (targetQuantity === 0) return 0;
    return (currentQuantity / targetQuantity) * 100;
};

export const getDealPhase = (
    status: DealStatus,
    now: Date,
    startDate: Date,
    endDate: Date
): DealPhase => {
    if (status === DealStatus.COMPLETED) return DealPhase.COMPLETED;
    if (status === DealStatus.CANCELLED) return DealPhase.CANCELLED;

    if (now < startDate) return DealPhase.FUTURE;
    if (status === DealStatus.EXTENDED) return DealPhase.EXTENDED;
    if (now >= startDate && now <= endDate) return DealPhase.ACTIVE;

    // If time is up but status hasn't been updated yet, it's technically pending resolution,
    // but for display purposes it might still be considered active or awaiting resolution.
    // However, based on strict status:
    return status as unknown as DealPhase;
};

export interface ResolveDealParams {
    status: DealStatus;
    completionPercent: number;
    autoExtend: boolean;
    hasBeenExtended: boolean; // Derived from checking if status was already EXTENDED or if extension flag is set
    now: Date;
    endDate: Date;
}

export const resolveDealStatus = (params: ResolveDealParams): DealResolutionResult => {
    const { status, completionPercent, autoExtend, hasBeenExtended, now, endDate } = params;

    // Only resolve if time is up
    if (now < endDate && status !== DealStatus.COMPLETED && status !== DealStatus.CANCELLED) {
        return { newStatus: status, message: 'Deal is still active' };
    }

    if (completionPercent >= 70) {
        return { newStatus: DealStatus.COMPLETED, message: 'Deal reached target' };
    }

    if (completionPercent < 50) {
        return { newStatus: DealStatus.CANCELLED, message: 'Deal failed to reach 50%' };
    }

    // Between 50% and 70%
    if (autoExtend && !hasBeenExtended) {
        const newEndDate = new Date(endDate);
        newEndDate.setDate(newEndDate.getDate() + 3); // Add 3 days
        return {
            newStatus: DealStatus.EXTENDED,
            newEndDate,
            message: 'Deal extended by 3 days',
        };
    }

    // If already extended or autoExtend is false
    return { newStatus: DealStatus.CANCELLED, message: 'Deal failed to reach 70% after extension/time up' };
};
