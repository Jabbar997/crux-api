import { Router } from 'express';
import { SuppliersController } from './suppliers.controller';

const router = Router();
const suppliersController = new SuppliersController();

router.get('/', suppliersController.getAll.bind(suppliersController));
router.get('/:id', suppliersController.getById.bind(suppliersController));
router.post('/', suppliersController.create.bind(suppliersController));
router.put('/:id', suppliersController.update.bind(suppliersController));
router.delete('/:id', suppliersController.delete.bind(suppliersController));

export default router;
