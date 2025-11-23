import { Router } from 'express';
import { PaymentsController } from './payments.controller.js';

const router = Router();
const paymentsController = new PaymentsController();

router.post('/', paymentsController.create.bind(paymentsController));
router.post('/:id/paid', paymentsController.markAsPaid.bind(paymentsController));
router.post('/:id/failed', paymentsController.markAsFailed.bind(paymentsController));
router.post('/:id/refund', paymentsController.refund.bind(paymentsController));
router.get('/order/:id', paymentsController.getByOrder.bind(paymentsController));

export default router;
