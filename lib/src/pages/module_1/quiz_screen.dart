import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:security_info_project/src/models/question.dart';
import 'package:security_info_project/src/pages/module_1/result_screen.dart';
import 'package:security_info_project/src/widgets/AnswerCard.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:security_info_project/src/widgets/NextButton.dart';
import 'package:security_info_project/src/widgets/textNormal.dart';
import 'package:security_info_project/src/widgets/textNormalDark.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quizPath});
  final String quizPath;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  String? question;
  Future<void>? _loadQuestionsFuture;

  @override
  void initState() {
    super.initState();
    _loadQuestionsFuture = _loadQuestionsFromAsset();
  }

  Future<void> _loadQuestionsFromAsset() async {
    try {
      final jsonString = await rootBundle.loadString(widget.quizPath);
      final List<Map<String, dynamic>> jsonList =
          List<Map<String, dynamic>>.from(json.decode(jsonString));

      questions = jsonList.map((json) => Question.fromJson(json)).toList();
      questions.shuffle();

      final selectedQuestions = questions.take(10).toList();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        questions = selectedQuestions;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load questions: $e')),
      );
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
    return WillPopScope(
      onWillPop: () async {
        showCustomDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: const CyberFunkAppBar(),
        body: FutureBuilder(
          future: _loadQuestionsFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final question = questions[questionIndex];
              bool isLastQuestion = questionIndex == questions.length - 1;
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textNormalDark(30, question.question).animate().fadeIn(),
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
                          ).animate().fadeIn().moveY(begin: 5.0),
                        );
                      },
                    ),
                    textNormal(20, "Pregunta $questionIndex / 10"),
                    // Next Button
                    isLastQuestion
                        ? RectangularButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => ResultScreen(
                                      score: score,
                                    ),
                                  ),
                                  (_) => false);
                            },
                            label: 'Terminar',
                          )
                        : RectangularButton(
                            onPressed: selectedAnswerIndex != null
                                ? goToNextQuestion
                                : null,
                            label: 'Siguiente',
                          ),
                  ],
                ),
              );
            } else {
              // The questions are not loaded yet, you can show a loading indicator here
              return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.black, size: 80.0),
              );
            }
          },
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '¿Estás seguro que quieres abandonar el quiz?',
            style: GoogleFonts.inter(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Perderás tu progreso.',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                
                Navigator.of(context).pop(); 
                Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
