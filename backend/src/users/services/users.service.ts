import { Injectable } from '@nestjs/common';
import { UserRepository } from '../repository/user.repository';
@Injectable()
export class UsersService {
  constructor(private readonly userRepository: UserRepository) {}
}
