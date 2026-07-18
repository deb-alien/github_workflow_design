import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  Index,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Role } from '../enums/role.enum';
import { UserStatus } from '../enums/user-status.enum';

@Entity({ name: 'users' })
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true, nullable: false, length: 255 })
  @Index({ unique: true })
  email: string;
  @Column({ nullable: true, length: 255 })
  passwordHash?: string;

  @Column({ nullable: true, length: 255 })
  firstName: string;
  @Column({ nullable: true, length: 255 })
  lastName: string;
  @Column({ nullable: true, length: 255 })
  avatar: string;

  @Column({ default: false })
  emailVerified: boolean;
  @Column({ type: 'timestamp', nullable: true })
  emailVerifiedAt: Date;

  @Column({ type: 'enum', enum: Role, default: Role.USER })
  role: Role;

  @Column({ type: 'enum', enum: UserStatus, default: UserStatus.ACTIVE })
  @Index({ unique: false })
  status: UserStatus;

  @Column({ unique: true, nullable: true, length: 255 })
  @Index({ unique: true })
  provider: string;

  @Column({ nullable: true, length: 255 })
  @Index({ unique: true })
  providerId: string;

  @Column({ type: 'timestamp', nullable: true })
  lastLoginAt: Date;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;
  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;
  @DeleteDateColumn({ name: 'deleted_at' })
  deletedAt: Date;
}
