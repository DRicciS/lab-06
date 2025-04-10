# lab-05

## Create your first ruby and rails models

In this evaluation, you will be asked to create the first models of your web application `Whats New` using Ruby on Rails.

## Instructions

### 1. Create models and database tables

You will have to create at least 3 independent models (and tables). Later on the course we will learn to create associations between models, for the moment all models will be independent from each other.

#### 1.1 Creation of the `User` model and database table

Create the `User` models and respective database table with at least the following attributes:

- `email` (of type `string`)
- `first_name` (type `string`)
- `last_name` (type `string`)
- `created_at`` (type`datetime`)
- `updated_at` (type `datetime`)

#### 1.2 Creation of the `Chat` model and database table

Create the `Chat` model and respective database table with the following attributes:

- `sender_id` (of type `integer`)
- `receiver_id` (type `integer`)
- `created_at` (type `datetime`)
- `updated_at` (type `datetime`)

#### 1.3 Creation of the `Message` model and database table

Create the `Message` model and respective database table with the following attributes:

- `chat_id` (type `integer`)
- `user_id` (type `integer`)
- `body` (type `text`)
- `created_at` (type `datetime`)
- `updated_at` (type `datetime`)

All attributes must be `NOT NULL` at the database level.

### 2. Create dummy data

Populate the `db/seeds.rb` file with at least 10 instances of each model. This file is used to populate the database with data using `create` statements and is executed by running `bin/rails db:seed`.