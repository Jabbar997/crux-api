import { Router } from 'express';
import { DealsController } from './deals.controller.js';

const router = Router();
const dealsController = new DealsController();

router.get('/future', dealsController.getFuture.bind(dealsController));
router.get('/active', dealsController.getActive.bind(dealsController));
router.get('/completed', dealsController.getCompleted.bind(dealsController));
router.get('/:id', dealsController.getById.bind(dealsController));
router.post('/', dealsController.create.bind(dealsController));
router.post('/:id/resolve', dealsController.resolve.bind(dealsController));

export const dealsRouter = router;
export default router;
