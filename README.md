# README

* Database creation

* Database initialization

* Deployment instructions

* Flow

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

## Flow

First we will create a user from the /signup endpoint. From which we can create it without passing anything about the fee configuration, and the default one will be created with everything activated and 1% fee for trades and payments. Or if not, you can pass the attributes that you see necessary within the object (it is not mandatory to pass all 4, if you want to leave any of them as they are by default, they can be left that way). I leave a sample of the payload:

```
{
    "user": {
        "email": "test01@test.com",
        "password": "123456",
        "fee_configuration": {
            "trades": true,
            "trades_percentage": 11,
            "payments": false,
            "payments_percentage": 5
        }
    }
}
```

Once we have registered, within the header it will return the authorization with which we will have to interact with the back to be able to continue carrying out the following steps.
