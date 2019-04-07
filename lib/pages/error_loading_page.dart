import 'package:flutter/material.dart';
import './landing_page.dart';

class ErrorLoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.redAccent,
        child: new InkWell(
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new LandingPage()),
              (Route route) => route == null),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.error,
                size: 72.0,
              ),
              new Text("Error retriving data"),
              new Text("Tap to go back")
            ],
          ),
        ));
  }
}
