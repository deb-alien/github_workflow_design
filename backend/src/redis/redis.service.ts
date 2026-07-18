import { Injectable } from '@nestjs/common';
import { RedisProvider } from './providers/redis.provider';

@Injectable()
export class RedisService {
  constructor(private readonly redisProvider: RedisProvider) {}

  getClient() {
    return this.redisProvider.getClient();
  }
}
