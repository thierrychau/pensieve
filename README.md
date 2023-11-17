# Pensieve MVP Specification
A simple application that allows users to log in personal memories, get a journalized view, and share them to family and friends.

## Pain Point
Keeping track and organizing memories is not easy.

## User Stories
- As a user, I want to log in to access and manage my memories
- As a user, I want to register for an account to create and manage my memories
- As a user, I want a dashboard where I can view all my created memories and manage them
- As a user, I want to create a new memory with details like date, location, and description
- As a user, I want to delete a memory that is no longer relevant
- As a user, I want to edit details of a memory

## Domain Model

### Users
- id
- email:citext
- password:string
- (devise fields)

### People
- id
- first_name:string
- last_name:string
- user_id:references

### Memories
- id
- date
- title
- description
- author_id
- address_id

### People Memories
- id
- memory_id:references
- people_id:references

### Addresses
- id
- location
- address
- country
- country_code_alpha_3
- full_address
- place_formatted
- postcode
- region
- lat
- lng
