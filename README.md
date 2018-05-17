# README

## Setup
I'm using `Rails 5.2.0` and `Ruby 2.5.1` for this application.

There are a few dependencies before you can run this on your own machine:
- postgresql
- yarn

Running `./bin/setup` will setup the application and the database for you.

## Assets
I'm using yarn to manage vendored JS packages.

I'm using the following libraries:
- Bulma: A CSS framework. Just makes it easier to layout sections for this app.
- Clipboard: Cross-browser support for copying things into the clipboard. I didn't want to reinvent the wheel.
- Vue: A bit of an overkill just for the format validation of the URL in the form, but I find it way cleaner than using inline jQuery.

## Controllers
There's only two controllers for this app, `shortened_urls_controller.rb` and the `stats_controller.rb`

### `ShortenedUrlsController`

There's only three major parts of the app:
- Creating the shortened URL
- Showing it to the user
- The stats API

This controller is responsible for the first two.

I've also added a `Stats` module in `app/controllers/concern/stats.rb` that is just responsible for
capturing requests to shortened URLs and storing them in the database.
This keeps our controller skinny and uncluttered.

### `StatsController`

This is the API for getting statistics for shortened URL. The path `/stats` just takes on a query string `url` with the full shortened URL as the value.

Sample request:

`curl --request PUT "https://url_shortener.dev/stats?url=https://url_shortener.dev/ZbJq2BfK0r-Ky-lUJTp2RQ"`

Sample response:

```json
{
    "click_stats": {
        "summary": {
            "total_clicks": 1
        },
        "visits": [
            {
                "id": 4,
                "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36",
                "ip_address": "127.0.0.1",
                "referrer": null,
                "shortened_url_id": 1,
                "created_at": "2018-05-17T07:48:21.686Z",
                "updated_at": "2018-05-17T07:48:21.686Z"
            }
        ]
    }
}
```

## Models
There's only two models for this app: `ShortenedUrl` and `Visit`.

### `ShortenedUrl`
This is the model for every shortened URL created in the app.

There's only two fields, `original_url` and the `unique_name`.

Before it gets created, we generate a 7 character string as the unique name for the url.

We also keep the `original_url` so that we know where to redirect to.

#### SecureRandom.urlsafe_base64

In the model's callback, I'm using `SecureRandom.urlsafe_base64(3)` in order to generate a "unique" short name for the URL.

`SecureRandom` isn't really unique, but collisions are just unlikely to happen.

It still can definitely happen and there are solutions around it like adding retries to the string creation
to make sure you've created a unique string. But creating a solution around that felt like I would be over-engineering
things for this exercise.

### `Visit`
Visit represents each visitor for a shortened URL.

It stores three things:
- IP Address
- User Agent
- Referrer URL

I just went through and inspected `request.env` to see which stats could be useful for links.

The number of visits would be the most important one. Then the details for the visitor like the client's IP, their browser details and where they clicked the link from.

## Testing
For this app, I've decided to stick to using MiniTest for the unit and integration tests.
I prefer using Rspec for larger code bases, but for simple applications, MiniTest does the job just fine!

Run the tests with `rails test`.

The integration tests are in `test/integration`. I've decided to split up the integration tests
based on the interactions the user has with the application.

You will also notice that only `ShortenedUrl` has a unit test.
This is because it's the only object that has logical behaviour within itself that warrants a unit test.

The behaviour for creating the `Visit` object is done in the controller and is being handled by the integration tests.

