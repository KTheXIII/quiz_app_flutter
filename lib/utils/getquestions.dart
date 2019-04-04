import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class GetQuestions {
  final String _url =
      "https://opentdb.com/api.php?amount=10&category=18&difficulty=medium&type=boolean";

  GetQuestions();

  Future<String> makeRequest() async {
    var res = await http.get(Uri.encodeFull(_url));

    List data;

    var extractData = json.decode(res.body);
    data = extractData["results"];

    print(data);
  }
}
