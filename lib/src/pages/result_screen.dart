import 'package:flutter/material.dart';
import 'package:security_info_project/src/models/questions.dart';
import 'package:security_info_project/src/pages/badge_screen.dart';
import 'package:security_info_project/src/pages/video_screen.dart';
import 'package:security_info_project/src/widgets/ButtonGeneralAction.dart';
import 'package:security_info_project/src/widgets/textNormalDark.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 1000),
          textNormalDark(30, "Resultados"),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 9,
                  color: Colors.green,
                  backgroundColor: Colors.white,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(score / questions.length * 100).round()}%',
                    style: const TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
          buttonGeneralAction("Continuar", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => score >= 8 ? const BadgeScreen(
                    // textPassed: textToSend,
                    ) : const VideoCourseScreen(
                    // textPassed: textToSend,
                    ) 
              ),
            );
          })
        ],
      ),
    );
  }
}
