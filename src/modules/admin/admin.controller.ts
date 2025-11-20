import { Request, Response } from 'express';
import { AdminService } from './admin.service';

const adminService = new AdminService();

export class AdminController {
    async getStats(req: Request, res: Response) {
        try {
            const stats = await adminService.getSystemStats();
            res.json({ success: true, data: stats });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getDeals(req: Request, res: Response) {
        try {
            const deals = await adminService.getDashboardDeals();
            res.json({ success: true, data: deals });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getUsers(req: Request, res: Response) {
        try {
            const users = await adminService.getUsers();
            res.json({ success: true, data: users });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getSuppliers(req: Request, res: Response) {
        try {
            const suppliers = await adminService.getSuppliers();
            res.json({ success: true, data: suppliers });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }

    async getOrders(req: Request, res: Response) {
        try {
            const orders = await adminService.getOrders();
            res.json({ success: true, data: orders });
        } catch (error: any) {
            res.status(500).json({ success: false, message: error.message });
        }
    }
}
