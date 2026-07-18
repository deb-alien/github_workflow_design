import * as joi from 'joi';

export default joi.object({
  NODE_ENV: joi.string().valid('development', 'production', 'test').required(),
  PORT: joi.number().default(3000),

  //* Database configuration
  DB_HOST: joi.string().required(),
  DB_PORT: joi.number().default(5432),
  DB_NAME: joi.string().required(),
  DB_USERNAME: joi.string().required(),
  DB_PASSWORD: joi.string().required(),
  DB_SSL_CA_PATH: joi.string().default('/app/certs/global-bundle.pem'),

  //* TypeORM configuration
  AUTO_LOAD_ENTITIES: joi.boolean().default(true),
  SYNC: joi.boolean().default(false),

  //* Redis/Valkey configuration
  REDIS_HOST: joi.string().required(),
  REDIS_PORT: joi.number().default(6379),
  REDIS_AUTH_TOKEN: joi.string().optional().allow(''),

  //* AWS S3 configuration
  AWS_REGION: joi.string().required(),
  AWS_ACCESS_KEY_ID: joi.string().optional(),
  AWS_SECRET_ACCESS_KEY: joi.string().optional(),
  BUCKET_NAME: joi.string().required(),
  USE_CLOUDFRONT: joi.boolean().default(process.env.NODE_ENV === 'production'),
});
