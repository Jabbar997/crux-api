import { Request, Response } from 'express';
import { SuppliersService } from './suppliers.service.js';

const suppliersService = new SuppliersService();

export class SuppliersController {
    async getAll(req: Request, res: Response) {
        try {
            const suppliers = await suppliersService.getAllSuppliers();
            res.json(suppliers);
        } catch (error: any) {
            res.status(500).json({ error: error.message });
        }
    }

    async getById(req: Request, res: Response) {
        try {
            const supplier = await suppliersService.getSupplierById(req.params.id);
            res.json(supplier);
        } catch (error: any) {
            res.status(404).json({ error: error.message });
        }
    }

    async create(req: Request, res: Response) {
        try {
            const supplier = await suppliersService.createSupplier(req.body);
            res.status(201).json(supplier);
        } catch (error: any) {
            res.status(400).json({ error: error.message });
        }
    }

    async update(req: Request, res: Response) {
        try {
            const supplier = await suppliersService.updateSupplier(req.params.id, req.body);
            res.json(supplier);
        } catch (error: any) {
            res.status(400).json({ error: error.message });
        }
    }

    async delete(req: Request, res: Response) {
        try {
            await suppliersService.deleteSupplier(req.params.id);
            res.status(204).send();
        } catch (error: any) {
            res.status(400).json({ error: error.message });
        }
    }
}
