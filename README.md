# README

* Database creation

* Database initialization

* Deployment instructions

* Postman instructions

* Flow

* Data modeling

* Error control

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

## Postman instructions

I have included in the project, within the docs/postman folder, both the folder containing the requests and the environment variables necessary to make the requests. You just need to take these files and import them into your Postman.

## Flow

First we will create a user from the /signup endpoint. From which we can create it without passing anything about the fee configuration, and the default one will be created with everything activated and 1% fee for trades and payments. Or if not, you can pass the attributes that you see necessary within the object (it is not mandatory to pass all 4, if you want to leave any of them as they are by default, they can be left that way). I leave a sample of the payload:

```
{
    "user": {
        "email": "test01@test.com",
        "password": "123456",
        "fee_configuration": {
            "trades": true,
            "trades_percentage": 1,
            "payments": true,
            "payments_percentage": 1
        }
    }
}
```

Once we have registered, within the header it will return the authorization with which we will have to interact with the back to be able to continue carrying out the following steps.

If at any time there is an Authorization problem (401), remember to check that the JWT token is being correctly set in the headers.

We will proceed to log in with the user and then make a POST request to api/v1/fiat_payments. Here we will introduce a payload like this:

```
{
    "fiat_payment": {
        "amount_cents": -10000
    }
}
```

Once done, it will return the fiat_payment and a 200 result if everything went successfully. Now, we just need to go to the endpoint to retrieve the user's information /api/v1/me, and here they will return the fees that have been charged and those that have not been charged this month."

Here is a payload example of the response that the API should return:

```
{
    "data": {
        "id": "95b90d0f-8631-4edc-9b25-fb5294f2da52",
        "type": "user",
        "attributes": {
            "email": "dinero3@test.com",
            "created_at": "2024-04-30T15:46:56.692Z",
            "fees": {
                "paid_fees": [
                    {
                        "amount_cents": 100,
                        "amount_currency": "EUR"
                    }
                ],
                "unpaid_fees": [
                    {
                        "amount_cents": 100,
                        "amount_currency": "EUR"
                    },
                    {
                        "amount_cents": 118,
                        "amount_currency": "USDT"
                    }
                ]
            }
        },
        "relationships": {
            "fee_configuration": {
                "data": {
                    "id": "95b90d0f-8631-4edc-9b25-fb5294f2da52",
                    "type": "fee_configuration"
                }
            }
        }
    }
}
```

## Data modeling

The data modeling is depicted in the following image:
![Captura desde 2024-04-30 18-07-45](https://github.com/EnriqueRapelaDeveloper/blockchain_integrated_payment_service/assets/154092472/7bc0eff7-ea1e-4b8f-8747-ca8abce4360f)

As seen in the image, we have the user, from which the other necessary models depend. On one side, we have the fee configuration, where we will choose during creation whether payments or trades will be charged immediately or not.

On the other hand, we have fiat payments, which are the user's incoming funds.

We have trades, which are the conversions automatically performed from one currency to another, in this case, 'EUR' to 'USDT'.

And blockchain payments, which simulate the increase of this currency converted to a wallet.

Finally, we have fees, which have a polymorphic relationship with trades, fiat payments, and blockchain payments. They will be responsible for storing the generated fee with a `has_one` relationship to the aforementioned objects.

## Error control

To maintain a standard for errors, errors will follow this format consistently:

```
{
    "status": "error",
    "status_code": 200,
    "errors": [
        {
            "code": "invalid_record",
            "message": "This record does not meet the necessary requirements to be saved",
            "details": "Amount must be greater than or equal to 0",
            "path": "/api/v1/fiat_payments",
            "timestamp": "2024-04-30T18:27:29.588+02:00",
            "suggestion": "Please check the documentation and enter the correct parameters"
        }
    ]
}
```

All of this has been implemented using a concern within the controllers (app/controllers/concerns/api_error_handler.rb), which encapsulates the error or errors and returns them to users in the same format.

Also, keep in mind that for TradeError, which simulates a fictional conversion error, you only need to uncomment the mentioned line in the file (app/services/trade_service.rb:37). This will trigger a custom error that will log to the console as usual and additionally log to a log file located at log/trade.log. This log file contains only a brief message stating that an error has occurred. However, if it were an external API, we would send the entire payload there to pinpoint the cause of the error with both the payload and the response.
