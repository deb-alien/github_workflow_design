import { Global, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import redisConfig from './config/redis.config';
import { RedisProvider } from './providers/redis.provider';
import { RedisService } from './redis.service';

@Global()
@Module({
  imports: [ConfigModule.forFeature(redisConfig)],
  providers: [RedisProvider, RedisService],
  exports: [RedisService],
})
export class RedisModule {}
