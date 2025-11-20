import { PaymentStatus } from '@prisma/client';

export interface CreatePaymentDTO {
    orderId: string;
    amount: number;
    method: string;
}

export { PaymentStatus };
