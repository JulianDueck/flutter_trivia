import 'package:flutter/material.dart';
import 'package:trivia/data/questions.dart';
import 'package:trivia/screens/main_screen.dart';
import 'package:trivia/screens/questions_screen.dart';
import 'package:trivia/screens/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  final List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    activeScreen = MainScreen(changeScreen);
  }

  void changeScreen() {
    setState(() {
      activeScreen = QuestionsScreen(chooseAnswer);
    });
  }

  void restartQuiz() {
    setState(() {
      activeScreen = QuestionsScreen(chooseAnswer);
      selectedOptions.clear();
    });
  }

  void chooseAnswer(String option) {
    selectedOptions.add(option);

    if (selectedOptions.length == questions.length) {
      setState(() {
        activeScreen = ResultScreen(selectedOptions, restartQuiz);
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
