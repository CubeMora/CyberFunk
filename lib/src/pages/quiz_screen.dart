import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:security_info_project/src/models/question.dart';
import 'package:security_info_project/src/models/questions.dart';
import 'package:security_info_project/src/pages/result_screen.dart';
import 'package:security_info_project/src/widgets/AnswerCard.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:security_info_project/src/widgets/NextButton.dart';
import 'package:security_info_project/src/widgets/textNormal.dart';
import 'package:security_info_project/src/widgets/textNormalDark.dart';



class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestionsFromAsset();
  }

   Future<void> _loadQuestionsFromAsset() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/pool_preguntas_video1.json');
      final List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(json.decode(jsonString));

      
      questions = jsonList.map((json) => Question.fromJson(json)).toList();
   
      questions.shuffle();

     final selectedQuestions = questions.take(10).toList();

      setState(() {
        questions = selectedQuestions;
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;
    return Scaffold(
      appBar: CyberFunkAppBar(),
      body:Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textNormalDark(30, question.question),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: selectedAnswerIndex == null
                          ? () => pickAnswer(index)
                          : null,
                      child: AnswerCard(
                        currentIndex: index,
                        question: question.options[index],
                        isSelected: selectedAnswerIndex == index,
                        selectedAnswerIndex: selectedAnswerIndex,
                        correctAnswerIndex: question.correctAnswerIndex,
                      ),
                    );
                  },
                ),
                textNormal(20, "Pregunta $questionIndex / 10"),
                // Next Button
                isLastQuestion
                    ? RectangularButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => ResultScreen(
                                score: score,
                              ),
                            ),
                          );
                        },
                        label: 'Terminar',
                      )
                    : RectangularButton(
                        onPressed:
                            selectedAnswerIndex != null ? goToNextQuestion : null,
                        label: 'Siguiente',
                      ),
              ],
            ),
          
        
      ),
    );
  }
}