import { PrismaClient, Supplier } from '@prisma/client';

const prisma = new PrismaClient();

export class SuppliersService {
    async getAllSuppliers() {
        return await prisma.supplier.findMany();
    }

    async getSupplierById(id: string) {
        const supplier = await prisma.supplier.findUnique({
            where: { id },
        });
        if (!supplier) {
            throw new Error('Supplier not found');
        }
        return supplier;
    }

    async createSupplier(data: {
        name: string;
        contactPerson: string;
        phone: string;
        email?: string;
        address?: string;
        materialTypes: string[];
        isActive?: boolean;
    }) {
        const existingSupplier = await prisma.supplier.findUnique({
            where: { phone: data.phone },
        });

        if (existingSupplier) {
            throw new Error('Supplier with this phone already exists');
        }

        return await prisma.supplier.create({
            data: {
                name: data.name,
                contactPerson: data.contactPerson,
                phone: data.phone,
                email: data.email,
                address: data.address,
                materialTypes: data.materialTypes,
                isActive: data.isActive ?? true,
            },
        });
    }

    async updateSupplier(id: string, data: Partial<Supplier>) {
        const existing = await prisma.supplier.findUnique({ where: { id } });
        if (!existing) throw new Error('Supplier not found');

        return await prisma.supplier.update({
            where: { id },
            data,
        });
    }

    async deleteSupplier(id: string) {
        const existing = await prisma.supplier.findUnique({ where: { id } });
        if (!existing) throw new Error('Supplier not found');

        return await prisma.supplier.delete({
            where: { id },
        });
    }
}
