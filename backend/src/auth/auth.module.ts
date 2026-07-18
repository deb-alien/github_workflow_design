import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PasswordService } from '~/auth/services/password.service';
import { TokenService } from '~/auth/services/token.service';
import { UsersModule } from '~/users/users.module';
import { AuthController } from './auth.controller';
import { AuthService } from './services/auth.service';

@Module({
  imports: [UsersModule, JwtModule.register({})],
  providers: [AuthService, PasswordService, TokenService],
  controllers: [AuthController],
})
export class AuthModule {}
