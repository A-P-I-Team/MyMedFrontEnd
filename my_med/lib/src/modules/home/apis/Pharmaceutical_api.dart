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
    try {
      return [
        ActivePrescriptionModel(
          id: '123',
          medicine: 'Astominophen',
          dosage: 500,
          start: DateTime.now(),
          fraction: 'consumptionAmount',
          reminders: [],
          takenno: 12,
          consumptionDuration: '12:00:00',
          days: 15,
          notify: true,
          period: 14,
          prescription: 1,
        ),
      ];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  Future<PrescriptionModel?> getActivePrescriptionDetail(
      String activePrescriptionID) async {
    try {
      return PrescriptionModel(
        id: '',
        name: 'Astominophen',
        dosage: 500,
        doctor: Doctor(
            id: '',
            name: 'Mina',
            profession: 'Physician',
            avatar: Avatar(file: '')),
        consumptionAmount: '1/2',
        consumptionStart: DateTime.now(),
        consumptionTimes: 14,
        consumptionDuration: 'Every 12 hours',
        consumptionMethod: 'consumptionMethod',
        description: 'This a drug.',
        changeRequests: [],
        isActive: true,
        isGreen: true,
        isReminderOn: true,
      );
    } catch (e) {
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
