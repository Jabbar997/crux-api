import { Request, Response } from 'express';
import { OrdersService } from './orders.service';

const ordersService = new OrdersService();

export class OrdersController {
    async create(req: Request, res: Response) {
        try {
            const order = await ordersService.createOrder(req.body);
            res.status(201).json({ success: true, data: order });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async confirm(req: Request, res: Response) {
        try {
            const order = await ordersService.confirmOrder(req.params.id);
            res.json({ success: true, data: order });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async cancel(req: Request, res: Response) {
        try {
            const order = await ordersService.cancelOrder(req.params.id);
            res.json({ success: true, data: order });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async getByUser(req: Request, res: Response) {
        try {
            const orders = await ordersService.getOrdersByUser(req.params.id);
            res.json({ success: true, data: orders });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getByDeal(req: Request, res: Response) {
        try {
            const orders = await ordersService.getOrdersByDeal(req.params.id);
            res.json({ success: true, data: orders });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }
}
