import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateBlogDto {
  @IsNotEmpty()
  @IsString()
  @ApiProperty({ example: 'Blog Title' })
  title: string;

  @IsNotEmpty()
  @IsString()
  @ApiProperty({ example: 'Blog Description' })
  description: string;

  @IsString()
  @ApiProperty({ example: 'Blog Image' })
  image?: string;
}
