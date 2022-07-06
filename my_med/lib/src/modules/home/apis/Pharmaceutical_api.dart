import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/apis/core_api_methods.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/home/models/prescription_detail_model.dart';

class Pharmaceutical {
  final _api = CoreApi();

  Future<List<ActivePrescriptionModel>> getActivePrescription() async {
    try {} catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  Future<PrescriptionModel?> getActivePrescriptionDetail(
      String activePrescriptionID) async {
    try {} catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return null;
  }

  Future<bool> useDrug(
      String reminderID, bool isUsed, BuildContext context) async {
    try {
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<ReminderModel>> startPrescription({
    required String dateTime,
    required BuildContext context,
    required ActivePrescriptionModel activePrescriptionModel,
  }) async {
    try {} catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  Future<bool> setReminderNotificationStatus(
      String activePrescriptionID, bool isReminderActive) async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
