import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UsePipes,
  ValidationPipe,
  HttpStatus
} from "@nestjs/common";
import { BlogService } from './blog.service';
import { CreateBlogDto } from './dto/create-blog.dto';
import { UpdateBlogDto } from './dto/update-blog.dto';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { GetBlogDto } from './dto/get-blog.dto';

@ApiTags('Blog')

@Controller('blog')
export class BlogController {
  constructor(private readonly blogService: BlogService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new blog' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Created',
  })
  @UsePipes(new ValidationPipe({ transform: true }))
  create(@Body() createBlogDto: CreateBlogDto) {
    return this.blogService.create(createBlogDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all Blogs' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Ok',
    type: GetBlogDto,
    isArray: true,
  })
  findAll() {
    return this.blogService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a blog by id' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Ok',
    type: GetBlogDto,
  })
  findOne(@Param('id') id: string) {
    return this.blogService.findOne(+id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a blog by id' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Ok',
  })
  @UsePipes(new ValidationPipe({ transform: true }))
  update(@Param('id') id: string, @Body() updateBlogDto: UpdateBlogDto) {
    return this.blogService.update(+id, updateBlogDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a blog by id' })
  remove(@Param('id') id: string) {
    return this.blogService.remove(+id);
  }
}
