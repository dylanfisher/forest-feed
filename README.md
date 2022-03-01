# Forest::Feed
Sync a personal Instagram account with a Rails application running Forest CMS.

## Installation

```ruby
gem 'forest-shopify', git: 'https://github.com/dylanfisher/forest-shopify.git'
```

## Access Token

- Log in to Facebook and go to [Meta for Developers](https://developers.facebook.com/)
- Navigate to [My Apps](https://developers.facebook.com/apps)
- Create a new "Consumer" app. Follow prompts to set up the Instagram Basic Display API.
- Once the Instagram Basic Display app is created, use the `User Token Generator` to add an Instagram tester.
- On the client's Instagram account, go to settings > [Apps and Websites](https://www.instagram.com/accounts/manage_access/) > Tester Invites, and accept the invite.
- Go back to the Basic Display app via within Facebook and press the Generate Token button next to the authorized test user. You'll need to log in to the client's Instagram account.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
