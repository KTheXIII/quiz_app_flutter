import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import './quiz_page.dart';
import '../utils/questions.dart';
import './error_loading_page.dart';

class LandingPage extends StatelessWidget {
  final String _url = "https://opentdb.com/api.php?amount=10&type=boolean";
  List<Question> questions = [];

  Future<bool> makeRequest() async {
    var res = await http.get(Uri.encodeFull(_url));

    List data;

    var extractData = json.decode(res.body);
    data = extractData["results"];

    createQuestion(data);
    return true;
  }

  void createQuestion(List data) {
    for (var i = 0; i < data.length; i++) {
      String tmpQuestion = data[i]["question"].toString();
      tmpQuestion = tmpQuestion.replaceAll(new RegExp("&quot;"), "\"");
      tmpQuestion = tmpQuestion.replaceAll(new RegExp("&#039;"), "\'");
      tmpQuestion = tmpQuestion.replaceAll(new RegExp("&rsquo;"), "\’");
      bool tmpAnswer = data[i]["correct_answer"] == "True" ? true : false;
      questions.add(new Question(tmpQuestion, tmpAnswer));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        onTap: () {
          makeRequest().whenComplete(() {
            if (questions.length > 0)
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new QuizPage(questions)));
            else
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ErrorLoadingPage()),
                  (Route route) => route == null);
          });

          // Navigator.of(context).push(new MaterialPageRoute(
          //     builder: (BuildContext context) => new QuizPage(questions)));
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Let\'s Quiz",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
            new Text(
              "Tap to start!",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
