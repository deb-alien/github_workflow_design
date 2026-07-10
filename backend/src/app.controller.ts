import { Controller, Get, HttpCode, HttpStatus } from '@nestjs/common';

@Controller()
export class AppController {
  @Get('/health')
  @HttpCode(HttpStatus.OK)
  getHello() {
    return { status: 'ok', message: 'Service is running' };
  }
}
