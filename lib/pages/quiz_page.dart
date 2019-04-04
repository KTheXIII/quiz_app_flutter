import 'package:flutter/material.dart';

import '../utils/questions.dart';
import '../utils/quiz.dart';

import '../UI/question_text.dart';
import '../UI/answer_button.dart';
import '../UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizPage extends StatefulWidget {
  List<Question> _questions;

  QuizPage(this._questions);

  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz;

  String questionText;
  int questionNumber;
  bool isCorrect;

  bool showOverlay = false;

  @override
  void initState() {
    super.initState();
    quiz = new Quiz(widget._questions);

    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      showOverlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          // This is our main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        showOverlay
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  showOverlay = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : new Container()
      ],
    );
  }
}
