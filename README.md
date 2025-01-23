# Forest::Feed
Sync a personal Instagram account with a Rails application running Forest CMS.

## Installation

```ruby
gem 'forest-shopify', git: 'https://github.com/dylanfisher/forest-shopify.git'
```

## Access Token

You'll need to generate the first Instagram access token via the User Token Generator for you Instagram tester user. After this initial long-lived token is generated,
Forest::Feed will refresh the token each time the feed is synced. If all goes well you won't need to regenerate this token manually.

- Log in to Facebook and go to [Meta for Developers](https://developers.facebook.com/)
- Navigate to [My Apps](https://developers.facebook.com/apps)
- Create a new "Business" app. Follow prompts to add the Instagram product to your app.
- Click the "Generate access tokens" add account button. Log in and authorize with Instagram.
- Click the "Generate token" link in the newly added Instagram account.
- Once you have the token, go into the Forest dashboard and select the Token resource. Create a new token for the `Instagram` service, paste in the token code, the user ID, and the display user name (the Instagram handle).

## Rake Tasks

You'll want to run the following rake task hourly or daily to keep the feed up to date.

`rails forest:feed:sync`

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
