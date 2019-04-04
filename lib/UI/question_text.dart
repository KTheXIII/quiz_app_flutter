import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizrAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizrAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizrAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizrAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizrAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizrAnimationController.reset();
      _fontSizrAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: new Center(
          child: new Text(
            "Question " +
                widget._questionNumber.toString() +
                ": " +
                widget._question,
            style: new TextStyle(fontSize: _fontSizeAnimation.value * 15),
          ),
        ),
      ),
    );
  }
}
