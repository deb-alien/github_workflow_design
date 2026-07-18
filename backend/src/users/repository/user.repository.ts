import { Injectable, NotImplementedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entity/user.entity';
@Injectable()
export class UserRepository {
  constructor(
    @InjectRepository(User)
    private readonly repository: Repository<User>,
  ) {}

  public async create(user: User): Promise<User> {
    throw new NotImplementedException('Method not implemented.');
  }

  public async save(user: User): Promise<User> {
    throw new NotImplementedException('Method not implemented.');
  }

  public async findOneById(id: string): Promise<User | null> {
    throw new NotImplementedException('Method not implemented.');
  }

  public async findOneByEmail(email: string): Promise<User | null> {
    throw new NotImplementedException('Method not implemented.');
  }

  public async findOneByProviderAndProviderId(
    provider: string,
    providerId: string,
  ): Promise<User | null> {
    throw new NotImplementedException('Method not implemented.');
  }
}
