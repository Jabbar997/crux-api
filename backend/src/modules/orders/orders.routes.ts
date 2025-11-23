import { Router } from 'express';
import { OrdersController } from './orders.controller.js';

const router = Router();
const ordersController = new OrdersController();

router.post('/', ordersController.create.bind(ordersController));
router.post('/:id/confirm', ordersController.confirm.bind(ordersController));
router.post('/:id/cancel', ordersController.cancel.bind(ordersController));
router.get('/user/:id', ordersController.getByUser.bind(ordersController));
router.get('/deal/:id', ordersController.getByDeal.bind(ordersController));

export default router;
