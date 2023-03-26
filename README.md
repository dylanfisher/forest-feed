# Forest::Feed
Sync a personal Instagram account with a Rails application running Forest CMS.

This approach uses the [Instagram Basic Display API](https://developers.facebook.com/docs/instagram-basic-display-api/overview).

## Installation

```ruby
gem 'forest-shopify', git: 'https://github.com/dylanfisher/forest-shopify.git'
```

## Access Token

You'll need to generate the first Instagram access token via the User Token Generator for you Instagram tester user. After this initial long-lived token is generated,
Forest::Feed will refresh the token each time the feed is synced. If all goes well you won't need to regenerate this token manually.

- Log in to Facebook and go to [Meta for Developers](https://developers.facebook.com/)
- Navigate to [My Apps](https://developers.facebook.com/apps)
- Create a new "Consumer" app. Follow prompts to set up the Instagram Basic Display API.
- Once the Instagram Basic Display app is created, use the `User Token Generator` to add an Instagram tester.
- On the client's Instagram account, go to settings > [Apps and Websites](https://www.instagram.com/accounts/manage_access/) > Tester Invites, and accept the invite.
- Navigate to the "Instagram Basic Display" heading in the Facebook developer sidebar panel and select "Basic Display". Press the Generate Token button next to the authorized test user. You'll need to log in to the client's Instagram account.
- Once you have the token, go into the Forest dashboard and select the Token resource. Create a new token for the `Instagram` service, paste in the token code, the user ID, and the display user name (the Instagram handle).

## Rake Tasks

You'll want to run the following rake task hourly or daily to keep the feed up to date.

`rails forest:feed:sync`

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
