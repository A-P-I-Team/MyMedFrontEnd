import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/constants/properties.dart';
import 'package:my_med/src/constants/urls.dart';
import 'package:my_med/src/core/apis/core_api_methods.dart';
import 'package:my_med/src/modules/home/models/active_prescription_detail_model.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';

class Pharmaceutical {
  final _api = CoreApi();

  Future<List<ActivePrescriptionModel>> getActivePrescription({
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse(ConstURLs.activePrescription),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );

      if (response == null || response.body.isEmpty) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      final decodedJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode != 200) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      if (decodedJson is! List) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }

      final dataList = decodedJson;
      var prescriptionList = <ActivePrescriptionModel>[];
      for (var prescription in dataList) {
        prescriptionList.add(ActivePrescriptionModel.fromJson(
            prescription as Map<String, dynamic>));
      }
      return prescriptionList;
    } on ApiError catch (_) {
      onAPIError();
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  Future<ActivePrescriptionDetailModel?> getActivePrescriptionDetail({
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
    required String activePrescriptionID,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse('${ConstURLs.drug}$activePrescriptionID/'),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );

      if (response == null || response.body.isEmpty) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      final decodedJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode != 200) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      // if (decodedJson! is Map<String, dynamic>) {
      //   throw ApiError(message: APIErrorMessage().serverMessage);
      // }

      var activePrescDetail = ActivePrescriptionDetailModel.fromJson(
        decodedJson,
        activePrescriptionID,
      );

      return activePrescDetail;
    } on ApiError catch (_) {
      onAPIError();
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      debugPrint(e.toString());
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
