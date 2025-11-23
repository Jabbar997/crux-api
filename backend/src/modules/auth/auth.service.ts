import prisma from '../../lib/prisma.js';
import { User } from '@prisma/client';
import jwt from 'jsonwebtoken';
import { hashPassword, comparePassword } from '../../utils/password.util.js';
import { RegisterDTO, LoginDTO, AuthResponse } from './auth.types.js';

const JWT_SECRET = process.env.JWT_SECRET || 'supersecretkey';

export class AuthService {
    async createUser(data: RegisterDTO): Promise<AuthResponse> {
        const existingUser = await prisma.user.findUnique({
            where: { phone: data.phone },
        });

        if (existingUser) {
            throw new Error('Phone number already registered');
        }

        const hashedPassword = await hashPassword(data.password);

        const user = await prisma.user.create({
            data: {
                name: data.name,
                phone: data.phone,
                password: hashedPassword,
                email: data.email,
                role: data.role || 'BUYER',
            },
        });

        const token = this.generateToken(user);

        return {
            token,
            user: {
                id: user.id,
                name: user.name,
                phone: user.phone,
                email: user.email,
                role: user.role,
            },
        };
    }

    async validateUser(data: LoginDTO): Promise<AuthResponse> {
        const user = await prisma.user.findUnique({
            where: { phone: data.phone },
        });

        if (!user) {
            throw new Error('Invalid credentials');
        }

        const isValid = await comparePassword(data.password, user.password);

        if (!isValid) {
            throw new Error('Invalid credentials');
        }

        const token = this.generateToken(user);

        return {
            token,
            user: {
                id: user.id,
                name: user.name,
                phone: user.phone,
                email: user.email,
                role: user.role,
            },
        };
    }

    private generateToken(user: User): string {
        return jwt.sign(
            { id: user.id, role: user.role },
            JWT_SECRET,
            { expiresIn: '7d' }
        );
    }
}
