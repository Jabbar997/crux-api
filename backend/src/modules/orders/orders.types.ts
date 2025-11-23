import { OrderStatus } from '@prisma/client';

export interface CreateOrderDTO {
    userId: string;
    dealId: string;
    quantity: number;
}

export { OrderStatus };
