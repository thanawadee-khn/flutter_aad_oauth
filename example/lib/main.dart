import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'launcher.dart';

void main() => runApp(MyApp());

bool isLoggedIn = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAD OAuth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AAD OAuth Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final Config config = Config(
    tenant: "YOUR_TENANT_ID",
    clientId: "YOUR_CLIENT_ID",
    scope: "openid profile offline_access",
    redirectUri: 'https://login.live.com/oauth20_desktop.srf',
  );
  final AadOAuth oauth = AadOAuth(config);
  static var userInfo;
  void initState() {
    super.initState();
    if (isLoggedIn) {
      logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    // adjust window size for browser login
    var screenSize = MediaQuery.of(context).size;
    var rectSize =
        Rect.fromLTWH(0.0, 25.0, screenSize.width, screenSize.height - 25);
    oauth.setWebViewScreenSize(rectSize);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            leading: Icon(Icons.launch),
            title: Text('Login'),
            onTap: () {
              login();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Launcher()),
            );
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login() async {
    try {
      await oauth.login();
      var accessToken = await oauth.getAccessToken();
      userInfo = Jwt.parseJwt(accessToken);
      isLoggedIn = true;
      showMessage('Logged in successfully');
    } catch (e) {
      showError(e);
    }
  }

  void logout() async {
    await oauth.logout();
    isLoggedIn = false;
  }
}

//new

class Profile extends StatelessWidget {
  final homePage = _MyHomePageState();
  var userInfo = _MyHomePageState.userInfo['given_name'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              _MyHomePageState().logout();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body:
      Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30.0),
              child: Image(
                image: AssetImage('assets/user.png'),
                width: 150,
                height: 150,
              )
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Firstname: ${_MyHomePageState.userInfo['given_name']}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ))
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Text('Lastname: ${_MyHomePageState.userInfo['family_name']}',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                )
              )
            )
          ],
        )
      ),
    );
  }

  // void logout() async {
  //   await _MyHomePageState().logout();
  // }
}
