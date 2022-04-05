import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:my_med/src/models/date.dart';

class RegisterController {
  final nameController = TextEditingController();
  Date? birthDate;
  Uint8List? photo;
  String? photoPath;
  File? profilePhotoFile;

  bool get areQuestionsAnswered {
    return true;
  }
}
