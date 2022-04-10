
import 'package:flutter/material.dart';
import 'package:quizapp/home.dart';
import 'package:quizapp/model/question.dart';
import 'package:quizapp/parsing_json/json_parsing.dart';
import 'package:quizapp/parsing_json/json_parsing_map.dart';

void main() => runApp(new MaterialApp(
  home: JsonParsingMap(),
));


class QuizApp extends StatefulWidget {
  const QuizApp({ Key? key }) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  int _currenctQuestionIndex = 0;

  List questionBank = [
    Question.name('The U.S. declaparation of interfence was adoped in 1776', true),
    Question.name('The superme law of the land is the Constituaion', true),
    Question.name('The Constituation has admdat 26', false),
    Question.name('The freedom religion means you can practice anu religion ', true),
    Question.name('The journalist is are branch part of the goverment', false),
    Question.name('The congres dont make federal laws', false),
    Question.name('There are 100 u.s. senators', true),
    Question.name('We select the senators for 4 years', false),
    Question.name('We vote to the president in juanary', false),
    Question.name('Bush is the father of country', false),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('True cirizen'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset("images/flag.png",
                width: 250,
                height: 150,),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(1.4),
                    border: Border.all(
                      color: Colors.blueGrey.shade400, style: BorderStyle.solid,
                    )
                    ),
                    height: 120.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(questionBank[_currenctQuestionIndex].questionText, style: TextStyle(
                      fontSize: 16.9,
                      color: Colors.white,
                    ),)),
                  ),
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  // prev button
                   RaisedButton(onPressed: () => _prevQuestion(),
                  color: Colors.blueGrey.shade900,
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                  ),

                  // True
                  RaisedButton(onPressed: () => _checkAnswer(true, context),
                  color: Colors.blueGrey.shade900,
                  child: Text('TRUE', style: TextStyle(color: Colors.white),),
                  ),
      
                  // False
                  RaisedButton(onPressed: () => _checkAnswer(false, context),
                  color: Colors.blueGrey.shade900,
                  child: Text('FALSE', style: TextStyle(color: Colors.white),),
                  ),
      
                  // Next button
                  RaisedButton(onPressed: () => _nextQuestion(),
                  color: Colors.blueGrey.shade900,
                  child: Icon(Icons.arrow_forward, color: Colors.white,)
                  ),
                ],
              ),
              Spacer(),
              // Image(image: AssetImage('images/flag.png'),),
            ],
          ),
        ),
      ),
    );
  }
  _checkAnswer(bool userChoice, BuildContext context) {
    if(userChoice == questionBank[_currenctQuestionIndex].isCorrect){
      debugPrint('Answer TRUE!');
      final snackbar= SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 500),
        content: Text('Correct'));
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      debugPrint('Incorrect');
      final snackbar= SnackBar(
        backgroundColor: Colors.redAccent,
        action: SnackBarAction(label: 'Undo', onPressed: () => {
          // go to next question
          _nextQuestion()
        },),
        duration: Duration(milliseconds: 500),
        content: Text('Incorrect'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  _nextQuestion() {
    setState(() {
      _currenctQuestionIndex = (_currenctQuestionIndex + 1) % questionBank.length;
    });
  }

  _prevQuestion() {
    setState(() {
      _currenctQuestionIndex = (_currenctQuestionIndex - 1) % questionBank.length;
     });
     debugPrint('Index: $_currenctQuestionIndex');
  }
}