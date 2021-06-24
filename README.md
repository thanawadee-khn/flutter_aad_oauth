# OAuth Azure AD
### Usage
For using this library you have to create an azure app at the [Azure App registration portal](https://apps.dev.microsoft.com/). Use native app as platform type (with callback URL: https://login.live.com/oauth20_desktop.srf).
Go to `/example/lib/main.dart`
Afterwards you have to initialize the library as follow:

```dart
  static final Config config = new Config(
    tenant: "YOUR_TENANT_ID",
    clientId: "YOUR_CLIENT_ID",
    scope: "openid profile offline_access",
    redirectUri: "your redirect url available in azure portal"
  );

final AadOAuth oauth = new AadOAuth(config);
```

This allows you to pass in an tenant ID, client ID, scope and redirect url.
Read more: [Azure Active Directory OAuth](https://pub.dev/packages/aad_oauth)

### Install Packages
```
$ flutter pub get
```
### Run application
```
$ cd example
$ flutter run
```
