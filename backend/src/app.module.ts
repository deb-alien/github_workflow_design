import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import validateEnvironment from './config/validate-environment';
import { DatabaseModule } from './database/database.module';
import { RedisModule } from './redis/redis.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: ['.env.local', '.env'],
      validationSchema: validateEnvironment,
    }),
    DatabaseModule,
    RedisModule,
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule {}
