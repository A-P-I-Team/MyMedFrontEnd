import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:shamsi_date/shamsi_date.dart';

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
