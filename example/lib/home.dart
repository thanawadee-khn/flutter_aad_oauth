import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class ColleagueInfo {
  String name;
  String email;
  String avatar;
  ColleagueInfo(
    this.name,
    this.email,
    this.avatar
  );
}
 
class _HomeState extends State<Home> {

  var colleagues = [];
  var itemCount = 0;
  void initState() {
    super.initState();
    callAPI();
  }

  callAPI() {
    var url = "https://flutterapp-jirachai.azurewebsites.net/api/getColleagues?limit=10";
    http.get(url).then((response) {
      setState(() {
        if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
        itemCount = jsonResponse['limit'];
        print('Colleagues count: $itemCount.');
        colleagues.addAll(jsonResponse['colleagues']);
        print(colleagues[0]['name']);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      });
    });
  }

// Future<void> callAPI() async {
//   var url = "https://flutterapp-jirachai.azurewebsites.net/api/getColleagues";
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonResponse =
//     convert.jsonDecode(response.body) as Map<String, dynamic>;
//     itemCount = jsonResponse['limit'];
//     print('Colleagues count: $itemCount.');
//     colleagues.addAll(jsonResponse['colleagues']);
//     print(colleagues[0]['name']);
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: 
      itemCount > 0
      ? ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(colleagues[index]['avatar']),
                  ),
                title: Text('${colleagues[index]['name']}'),
                subtitle: Text('Email: ${colleagues[index]['name']}'),
                )
              ],
            ),
          );
          },
        )
      : Center(child: const Text('No items')),
    );
  }
}

