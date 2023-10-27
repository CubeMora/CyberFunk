class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,
  });

   factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['pregunta'],
      options: List<String>.from(json['opciones']),
      correctAnswerIndex: json['respuesta_correcta'],
    );
  }
}