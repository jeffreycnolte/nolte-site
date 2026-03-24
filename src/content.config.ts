import { defineCollection, z, reference } from 'astro:content';
import { glob } from 'astro/loaders';

const authors = defineCollection({
  loader: glob({ pattern: '**/*.json', base: './src/content/authors' }),
  schema: z.object({
    name: z.string(),
    role: z.string(),
    bio: z.string(),
    avatar: z.string().optional(),
    linkedin: z.string().url().optional(),
    twitter: z.string().url().optional(),
  }),
});

const categories = defineCollection({
  loader: glob({ pattern: '**/*.json', base: './src/content/categories' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    scope: z.enum(['blog', 'work', 'both']),
  }),
});

const blog = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    updated: z.coerce.date().optional(),
    author: z.string(),
    category: z.string(),
    image: z.string().optional(),
    imageAlt: z.string().optional(),
    draft: z.boolean().default(false),
  }),
});

const work = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/work' }),
  schema: z.object({
    title: z.string(),
    client: z.string(),
    description: z.string(),
    category: z.string(),
    date: z.coerce.date(),
    status: z.string(),
    partnership: z.string(),
    image: z.string().optional(),
    imageAlt: z.string().optional(),
    services: z.array(z.string()).optional(),
    draft: z.boolean().default(false),
  }),
});

export const collections = { authors, categories, blog, work };
