import { registerAs } from '@nestjs/config';

export default registerAs('database', () => ({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT || '5432', 10),
  name: process.env.DB_NAME,
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  autoLoadEntities: process.env.AUTO_LOAD_ENTITIES === 'true',
  synchronize: process.env.SYNC === 'true',
  sslCaPath:
    process.env.NODE_ENV === 'production'
      ? process.env.DB_SSL_CA_PATH
      : undefined,
}));
