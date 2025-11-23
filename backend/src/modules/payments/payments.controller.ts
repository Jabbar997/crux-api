import { Request, Response } from 'express';
import { PaymentsService } from './payments.service.js';

const paymentsService = new PaymentsService();

export class PaymentsController {
    async create(req: Request, res: Response) {
        try {
            const payment = await paymentsService.createPayment(req.body);
            res.status(201).json({ success: true, data: payment });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async markAsPaid(req: Request, res: Response) {
        try {
            const payment = await paymentsService.markPaymentAsPaid(req.params.id);
            res.json({ success: true, data: payment });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async markAsFailed(req: Request, res: Response) {
        try {
            const payment = await paymentsService.markPaymentAsFailed(req.params.id);
            res.json({ success: true, data: payment });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async refund(req: Request, res: Response) {
        try {
            const payment = await paymentsService.refundPayment(req.params.id);
            res.json({ success: true, data: payment });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async getByOrder(req: Request, res: Response) {
        try {
            const payments = await paymentsService.getPaymentsByOrder(req.params.id);
            res.json({ success: true, data: payments });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }
}
