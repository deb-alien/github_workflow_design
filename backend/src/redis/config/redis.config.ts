import { registerAs } from '@nestjs/config';

export default registerAs('redis', () => ({
  host: process.env.REDIS_HOST,
  port: parseInt(process.env.REDIS_PORT || '6379', 10),
  authToken: process.env.REDIS_AUTH_TOKEN || undefined,
  isLocal: !process.env.REDIS_HOST || process.env.NODE_ENV === 'development',
}));
