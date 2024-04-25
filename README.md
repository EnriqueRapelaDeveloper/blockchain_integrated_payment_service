# README

* Database creation

* Database initialization

* Deployment instructions

## Database creation

Once you have the repository on your computer, follow these steps to configure the project:

1. In this step, we will copy the `.env.example` file and paste it with the name `.env`. This file contains the template of environment variables that the project needs to create the database. In Ubuntu, you can do this with `cp .env.example .env`, and the file will be generated for you.
2. Once we have the file, we need to fill it with our PostgreSQL username and password.

## Database initialization

1. When everything is set up, run the following commands:
```
rails db:create
rails db:migrate
```

## Deployment instructions

To start the project, run the command `rails s`