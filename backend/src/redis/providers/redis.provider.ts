// providers/redis.provider.ts
import {
  Inject,
  Injectable,
  Logger,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { type ConfigType } from '@nestjs/config';
import Redis from 'ioredis';
import redisConfig from '../config/redis.config';

@Injectable()
export class RedisProvider implements OnModuleInit, OnModuleDestroy {
  private readonly redis: Redis;
  private readonly logger: Logger = new Logger(RedisProvider.name);

  constructor(
    @Inject(redisConfig.KEY)
    private readonly config: ConfigType<typeof redisConfig>,
  ) {
    this.redis = new Redis({
      host: this.config.host,
      port: this.config.port,
      password: this.config.authToken,
      lazyConnect: true,
      tls: this.config.isLocal ? undefined : {},

      maxRetriesPerRequest: 3,
      enableReadyCheck: true,
      connectTimeout: 5000,
      retryStrategy(times) {
        return Math.min(times * 200, 2000);
      },
    });
  }

  async onModuleInit() {
    this.redis.on('connect', () => {
      this.logger.log('Valkey/Redis connecting...');
    });
    this.redis.on('ready', () => {
      this.logger.log('Valkey/Redis is READY');
    });
    this.redis.on('error', (err) =>
      this.logger.error('Valkey/Redis exception:', err),
    );

    try {
      await this.redis.connect();
    } catch (error) {
      this.logger.error(
        'Failed to establish initial handshakes with Valkey:',
        error instanceof Error ? error.message : String(error),
      );

      if (!this.config.isLocal) throw error;
    }
  }

  async onModuleDestroy() {
    await this.redis.quit();
  }

  getClient(): Redis {
    return this.redis;
  }
}
