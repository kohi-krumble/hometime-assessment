
# Hometime Assessment

Rails 7.1.6 API for creating reservations.
This app has one end point that can support two different payload structure.



## Features

- Tests will automaticall run when creating pull request or pushing to master branch via Github workflows
- Quick setup using Docker
- Authentication using [JWT](https://github.com/jwt/ruby-jwt)
- Phone number validations using [Phonelib](https://github.com/daddyz/phonelib) gem
- Currency handling using [Money-Rails](https://github.com/RubyMoney/money-rails)

## Run Locally

Prerequisite
- [Setup Rails on your machine](#rails-setup)
- [PostgreSQL installation](#postgresql-installation)
- Or run with [Docker](#docker-setup)

Clone the project
```bash
  git clone https://github.com/kohi-krumble/hometime-assessment.git
```
or download and extract [ZIP file](https://github.com/kohi-krumble/hometime-assessment/archive/refs/heads/master.zip)

Go to the project directory
```bash
  cd hometime-assessment
```

Install dependencies
```bash
  bundle install
```

Generaate credentials key
``` bash
  # development
  EDITOR="your-preferred-editor --wait" rails credentials:edit --environment development
  # This will create a development.key file on you config/credentials/

  # production
  EDITOR="your-preferred-editor --wait" rails credentials:edit --environment production
  # This will create a production.key file on you config/credentials/
```

Initialize database
```bash
  rails db:prepare
```

Start the server
```bash
  rails server
```
## API Reference

#### Create Reservation

```http
  POST /api/reservations
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| Authorization | `Bearer Token` | **Required**. Your API token ([how to generate token](#generate-your-token)) |
| Payload | `JSON` | **Required**. Reservation and guest details ([See sample payloads](#sample-payloads)) |

#### Payload version 1
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| start_date | `Date (Y-m-d)` | **Required**. Start of reservation |
| end_date | `Date (Y-m-d)` | **Required**. End of reservation |
| nights | `Integer` | **Required**. **Non-negative**. **Non-zero**. Number of nights of stay |
| guests | `Integer` | **Required**. **Non-negative**. **Non-zero**. Total number of guests |
| adults, children, infants | `Integer` | *Optional*. Total must be equal to `guests` |
| status | `String (pending\|accepted\|completed)` | *Optional*. Status of reservation. Defaults to `pending` |
| payout_price | `Decimal` | **Required**. **Non-negative**.  |
| security_price | `Decimal` | **Required**. **Non-negative**.  |
| total_price | `Decimal` | **Required**. **Non-negative**.  |
| currency | `string` | *Optional*. Defaults to AUD  |
| [guest](#guest-parameter) | `JSON` | **Required**. Guest who made the reservation  |

##### guest parameter
<a name="guest-parameter"></a>
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| id | `Integer` | **Required**. Guest ID |
| first_name | `String` | **Required**. Guest first name |
| last_name | `String` | *Optional*. Guest last name |
| phone | `String` | **Required**. Guest phone number |
| email | `String` | **Required**. Guest email |



#### Payload version 2
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| [reservation](#reservation-parameter) | `JSON` | **Required**. Reservation details |


##### reservation parameter
<a name="reservation-parameter"></a>
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| start_date | `Date (Y-m-d)` | **Required**. Start of reservation |
| end_date | `Date (Y-m-d)` | **Required**. End of reservation |
| nights | `Integer` | **Required**. **Non-negative**. **Non-zero**. Number of nights of stay |
| number_of_guests | `Integer` | **Required**. **Non-negative**. **Non-zero**. Total number of guests |
| status_type | `String (pending\|accepted\|completed)` | *Optional*. Status of reservation. Defaults to `pending` |
| expected_payout_amount | `Decimal` | **Required**. **Non-negative**.  |
| listing_security_price_accurate | `Decimal` | **Required**. **Non-negative**.  |
| total_paid_amount_accurate | `Decimal` | **Required**. **Non-negative**.  |
| host_currency | `string` | *Optional*. Defaults to AUD  |
| guest_id | `Integer` | **Required**. Guest ID |
| guest_first_name | `String` | **Required**. Guest first name |
| guest_last_name | `String` | *Optional*. Guest last name |
| guest_phone_numbers | `[String]` | **Required**. Guest phone number |
| guest_email | `String` | **Required**. Guest email |
| [guest_details](#guest-details-parameter) | `JSON` | **Required**. Guest who made the reservation  |


##### guest_details parameter
<a name="guest-details-parameter"></a>
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| localized_description | `String` | *Optional*. Reservation details description |
| number_of_adults, number_of_children, number_of_infants | `Integer` | *Optional*. Total must be equal to total `number_of_guests` |

## Sample payloads
#### Payload version 1
``` json
    {
        "start_date": "2026-03-12",
        "end_date": "2026-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00",
        "currency": "AUD",
        "guest": {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
        },
    }

```

#### Payload version 2
``` json
    {
        "reservation": {
            "start_date": "2026-03-12",
            "end_date": "2026-03-16",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "expected_payout_amount": "3800.00",
            "listing_security_price_accurate": "500.00",
            "total_paid_amount_accurate": "4500.00"
            "host_currency": "AUD",
            "guest_id": 1,
            "guest_first_name": "Wayne",
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
                "639123456789",
                "639123456789"
            ],
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_details": {
                "localized_description": "4 guests",
                "number_of_adults": 2,
                "number_of_children": 2,
                "number_of_infants": 0
            },
            
        }
    }

```
## Running Tests

To run tests, run the following command

```bash
  rails test
```


## Usage/Examples

#### Create your guest record
``` bash
    rails db:create_guest email="guest@example.com" first_name="Guest name" phone_number="639123456789"
    # > Guest created:
    #   ID: 4
    #   Email: testguest2@example.com

    # When using Docker
    # get container name
    docker ps
    # > CONTAINER ID   IMAGE    COMMAND     CREATED     STATUS  PORTS   NAMES

    docker exec web-container-name bundle exec rails db:create_guest email="guest@example.com" first_name="Guest name" phone_number="639123456789"
    # > Guest created:
    #   ID: 4
    #   Email: testguest2@example.com
```

#### Generate your token
<a name="generate-your-token"></a>
``` bash
    rails api:generate_token
    # > Generated JWT token:
    #   your-generated-token

    # When using Docker
    # get container name
    docker ps
    # > CONTAINER ID   IMAGE    COMMAND     CREATED     STATUS  PORTS   NAMES

    docker exec web-container-name bundle exec rails api:generate_token
    # > Generated JWT token:
    #   your-generated-token
```

### Create reservation
#### Using curl
```bash
curl -X POST http://localhost:3000/api/reservations \
-H "Content-Type: application/json" \
-H "Authorization: Bearer your-token" \
-d '{ 
        "start_date": "2026-03-12",
        "end_date": "2026-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00",
        "currency": "AUD",
        "guest": {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
        },
    }'
```
#### Or with a json file
``` bash
curl -X POST http://localhost:3000/api/reservations \
-H "Content-Type: application/json" \
-H "Authorization: Bearer your-token" \
-d @path/to/your/payload.json
```

#### Or modify fixture file from the codebase
``` bash
curl -X POST http://localhost:3000/api/reservations \
-H "Content-Type: application/json" \
-H "Authorization: Bearer your-token" \
-d @path/to/project/test/fixtures/files/reservation/payload-v1.json
```

#### Using Postman
https://github.com/user-attachments/assets/5a7f2c80-455f-4f4f-bc3c-f55ff489aa94

## Rails Setup
##### [Install Rails on Ubuntu](https://gorails.com/setup/ubuntu/26.04)
##### [Install Rails on Mac](https://gorails.com/setup/macos/26-tahoe)
##### [Install Rails on Windows](https://gorails.com/setup/windows/11)

## PostgreSQL Installation
##### [Install PostgreSQL on Ubuntu](https://www.postgresql.org/download/linux/ubuntu/)
##### [Install PostgreSQL on Mac](https://www.postgresql.org/download/macosx/)
##### [Install PostgreSQL on Windows](https://www.postgresql.org/download/windows/)

## Docker Setup
<a name="docker-setup"></a>
##### [Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
##### [Install Docker on Mac](https://docs.docker.com/desktop/setup/install/mac-install/)
##### [Install Docker on Windows](https://docs.docker.com/desktop/setup/install/windows-install/)



Set RAILS_MASTER_KEY on your .env file
``` bash
  # on project folder run
  echo "RAILS_MASTER_KEY=place-your-production.key-value-here" >> .env
```

Initialize containers
``` bash
  # on project folder run
  docker compose up --build
```
