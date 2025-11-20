import { Request, Response } from 'express';
import { DealsService } from './deals.service';

const dealsService = new DealsService();

export class DealsController {
    async getFuture(req: Request, res: Response) {
        try {
            const deals = await dealsService.getFutureDeals();
            res.json({ success: true, data: deals });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getActive(req: Request, res: Response) {
        try {
            const deals = await dealsService.getActiveDeals();
            res.json({ success: true, data: deals });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getCompleted(req: Request, res: Response) {
        try {
            const deals = await dealsService.getCompletedDeals();
            res.json({ success: true, data: deals });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getById(req: Request, res: Response) {
        try {
            const deal = await dealsService.getDealById(req.params.id);
            res.json({ success: true, data: deal });
        } catch (error: any) {
            res.status(404).json({ success: false, message: error.message });
        }
    }

    async create(req: Request, res: Response) {
        try {
            const deal = await dealsService.createDeal(req.body);
            res.status(201).json({ success: true, data: deal });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }

    async resolve(req: Request, res: Response) {
        try {
            const result = await dealsService.resolveDeal(req.params.id);
            res.json({ success: true, data: result });
        } catch (error: any) {
            res.status(400).json({ success: false, message: error.message });
        }
    }
}
