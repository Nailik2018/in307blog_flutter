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
  @ApiProperty({ example: 'https://ki-lian.ch/in307blog_images/tiny/fuer_den_fuchs.jpg' })
  image?: string;
}
