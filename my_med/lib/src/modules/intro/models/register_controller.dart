import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:my_med/src/models/date.dart';
import 'package:my_med/src/modules/intro/models/question.dart';

class RegisterController {
  final nameController = TextEditingController();
  Date? birthDate;
  Uint8List? photo;
  String? photoPath;
  final questions = [
    Question(
      question: 'What’s your Gender? *',
      questionApiValue: 'gender',
      answerType: AnswerType.radio,
      answers: [
        'Male',
        'Female',
        'Rather not to say',
      ],
      values: [
        'M',
        'F',
        'O',
      ],
    ),
  ];

  bool get areQuestionsAnswered {
    for (final question in questions) {
      if (question.isRequired && question.selectedAnswer == null) return false;
    }
    return true;
  }
}
