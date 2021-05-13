import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';

class Launcher extends StatefulWidget {
    static const routeName = '/';
 
    @override
    State<StatefulWidget> createState() {
        return _LauncherState();
    }
}
 
class _LauncherState extends State<Launcher> {
    int _selectedIndex = 0;
    List<Widget> _pageWidget = <Widget>[
        Home(),
        Profile()
    ];
    List<BottomNavigationBarItem> _menuBar
    = <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
        )
    ];
 
    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }
 
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: _pageWidget.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
                items: _menuBar,
                currentIndex: _selectedIndex,
                selectedItemColor: Theme
                    .of(context)
                    .primaryColor,
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
            ),
        );
    }
}