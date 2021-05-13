import 'package:flutter/material.dart';
 
class Home extends StatefulWidget {
    static const routeName = '/home';
 
    @override
    State<StatefulWidget> createState() {
        return _HomeState();
    }
}
 
class _HomeState extends State<Home> {
 
    @override
    Widget build(BuildContext context) {
 
        return Scaffold(
            appBar: AppBar(
                title: Text('Home'),
                automaticallyImplyLeading: false,
                centerTitle: true,
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('Home Screen'),
                    ],
                )
            ),
        );
    }
}