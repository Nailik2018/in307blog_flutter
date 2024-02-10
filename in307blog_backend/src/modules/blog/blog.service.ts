import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateBlogDto } from './dto/create-blog.dto';
import { UpdateBlogDto } from './dto/update-blog.dto';
import { Blog } from './entities/blog.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class BlogService {

  constructor(
    @InjectRepository(Blog)
    private readonly blogRepository: Repository<Blog>
  ) {
  }

  async create(createBlogDto: CreateBlogDto) {
    const blog = new Blog();
    blog.title = createBlogDto.title;
    blog.description = createBlogDto.description;
    blog.image = createBlogDto.image;
    return this.blogRepository.save(blog);
  }

  async findAll(): Promise<Blog[]> {
    return this.blogRepository.find();
  }

  async findOne(id: number): Promise<Blog | NotFoundException> {
    const entity = await this.blogRepository.findOne({
      where: { id }
    });

    if (!entity) {
      throw new NotFoundException(`Blog with id ${id} not found`);
    }
    return entity;
  }

  async update(id: number, updateBlogDto: UpdateBlogDto): Promise<Blog | NotFoundException | Error> {
    const existingBlog = await this.blogRepository.findOne({ where: { id } });
    existingBlog.title = updateBlogDto.title;
    existingBlog.description = updateBlogDto.description;
    existingBlog.image = updateBlogDto.image;
    return this.blogRepository.save(existingBlog);
  }

  async remove(id: number): Promise<Blog | NotFoundException> {
    const findDeletedBlog = await this.blogRepository.findOne({
      where: { id }
    });
    console.log(findDeletedBlog);
    if (!findDeletedBlog) {
      throw new NotFoundException(`Blog with id ${id} not found`);
    } else {
      await this.blogRepository.delete(id);
    }
    return findDeletedBlog;
  }
}
