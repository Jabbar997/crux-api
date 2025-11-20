export interface RegisterDTO {
    name: string;
    phone: string;
    password: string;
    email?: string;
    role?: 'BUYER' | 'SUPPLIER';
}

export interface LoginDTO {
    phone: string;
    password: string;
}

export interface AuthResponse {
    token: string;
    user: {
        id: string;
        name: string;
        phone: string;
        email: string | null;
        role: string;
    };
}
