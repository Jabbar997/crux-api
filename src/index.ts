import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import authRouter from './modules/auth/auth.routes';
import suppliersRouter from './modules/suppliers/suppliers.routes';
import dealsRouter from './modules/deals/deals.routes';
import ordersRouter from './modules/orders/orders.routes';
import paymentsRouter from './modules/payments/payments.routes';
import adminRouter from './modules/admin/admin.routes';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/auth', authRouter);
app.use('/suppliers', suppliersRouter);
app.use('/deals', dealsRouter);
app.use('/orders', ordersRouter);
app.use('/payments', paymentsRouter);
app.use('/admin', adminRouter);

// Root Endpoint
app.get('/', (req, res) => {
    res.json({ success: true, message: 'CRUX Backend Running' });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`CRUX API running on port ${PORT}`);
});
