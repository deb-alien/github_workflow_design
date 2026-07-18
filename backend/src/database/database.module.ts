// src/database/database.module.ts
import { Module } from '@nestjs/common';
import { ConfigModule, type ConfigType } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import fs from 'node:fs';
import databaseConfig from './config/database.config';

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule.forFeature(databaseConfig)],
      inject: [databaseConfig.KEY],
      useFactory: (config: ConfigType<typeof databaseConfig>) => {
        return {
          type: 'postgres',
          host: config.host,
          port: config.port,
          username: config.username,
          password: config.password,
          database: config.name,
          autoLoadEntities: config.autoLoadEntities,
          synchronize: config.synchronize,
          ssl: config.sslCaPath
            ? {
                rejectUnauthorized: true,
                ca: fs.readFileSync(config.sslCaPath, 'utf8'),
              }
            : false,
        };
      },
    }),
  ],
})
export class DatabaseModule {}
