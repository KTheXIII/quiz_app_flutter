import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../utils/questions.dart';

class TestPage extends StatefulWidget {
  @override
  State createState() => new TestPageSate();
}

class TestPageSate extends State<TestPage> {
  final String url =
      "https://opentdb.com/api.php?amount=10&category=18&difficulty=medium&type=boolean";
  List<Question> questions = [];
  List<Text> texts = [];
  String question = "";
  String displayText = "";

  Future<String> makeRequest() async {
    var res = await http.get(Uri.encodeFull(url));

    List data;

    var extractData = json.decode(res.body);

    data = extractData["results"];
    // print(data[0]["question"].toString());
    // print(data[0]);

    createQuestion(data);

    // this.setState(() {
    //   question = data[0]["question"].toString();
    //   question = question.replaceAll(new RegExp("&quot;"), "\"");
    // });
  }

  void createQuestion(List data) {
    displayText = "";

    for (var i = 0; i < 5; i++) {
      String tmpQuestion = data[i]["question"].toString();
      tmpQuestion = tmpQuestion.replaceAll(new RegExp("&quot;"), "\"");
      tmpQuestion = tmpQuestion.replaceAll(new RegExp("&#039;"), "\'");
      bool tmpAnswer = data[i]["correct_answer"] == "True" ? true : false;
      questions.add(new Question(tmpQuestion, tmpAnswer));
    }

    for (Question data in questions) {
      print("Q: " + data.question);
      print("A: " + data.answer.toString());

      this.setState(() {
        displayText += data.question + "\n\n";
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blue[200],
      child: new InkWell(
        onTap: () => makeRequest(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[new Text(displayText)],
        ),
      ),
    );
  }
}
