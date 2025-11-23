import { Router } from 'express';
import { AdminController } from './admin.controller.js';

const router = Router();
const adminController = new AdminController();

router.get('/stats', adminController.getStats.bind(adminController));
router.get('/deals', adminController.getDeals.bind(adminController));
router.get('/users', adminController.getUsers.bind(adminController));
router.get('/suppliers', adminController.getSuppliers.bind(adminController));
router.get('/orders', adminController.getOrders.bind(adminController));

export default router;
