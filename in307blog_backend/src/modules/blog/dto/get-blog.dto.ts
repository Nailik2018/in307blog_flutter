import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class GetBlogDto {
  @ApiProperty({ example: 18 })
  @IsNotEmpty()
  id: number;

  @ApiProperty({ example: 'Blog Title' })
  @IsNotEmpty()
  title: string;

  @ApiProperty({ example: 'Blog Description' })
  @IsNotEmpty()
  description: string;

  @ApiProperty({ example: 'https://ki-lian.ch/in307blog_images/tiny/fuer_den_fuchs.jpg' })
  image?: string;
}