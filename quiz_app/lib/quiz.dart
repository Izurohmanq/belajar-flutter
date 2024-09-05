import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget{
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// state di atas sama bawah harus sama State<Quiz>

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers =[];
  Widget? activeScreen;

  @override
  void initState() {
    super.initState();
    selectedAnswers = [];
    activeScreen = StartScreen(switchScreen);
  }

  @override
  void dispose() {
    selectedAnswers.clear();
    super.dispose();
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(chooseAnswer: selectedAnswers, onRestart: restartQuiz,);
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer,);
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = activeScreen = StartScreen(switchScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.indigo,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}