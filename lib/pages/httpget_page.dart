import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;

class ApiProvider {
  final String url = "https://swapi.co/api/people";
  Client client = Client();
  fetchPosts() async {
    final res = await client.get(
        // Encode the url
        Uri.encodeFull(url),
        // only accept json response
        headers: {"Accept": "application/json"});
    var data = json.decode(res.body);
    data = data['results'];

    return data;
  }
}

class GetPage extends StatefulWidget {
  @override
  State createState() => GetPageState();
}

class GetPageState extends State<GetPage> {
  final String url = "https://swapi.co/api/people";
  // final api = ApiProvider();
  Client client = Client();
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var res = await client.get(
        // Encode the url
        Uri.encodeFull(url),
        // only accept json response
        headers: {"Accept": "application/json"});

    // print(res.body);

    this.setState(() {
      var dataJSON = json.decode(res.body);
      data = dataJSON['results'];
    });

    return "success!";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hello there"),
        backgroundColor: Colors.greenAccent,
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
