import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

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

  Future<bool> useDrug({
    required String reminderID,
    required bool isUsed,
    required BuildContext context,
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required void Function(String message) onAPIError,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'status': isUsed,
      };
      final response = await _api
          .patch(
            Uri.parse('${ConstURLs.reminder}$reminderID/'),
            body: json.encode(body),
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

      if (decodedJson == null) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }

      if (response.statusCode != 200) {
        throw ApiError(
          message: decodedJson.containsKey('message')
              ? decodedJson['message'] as String
              : APIErrorMessage().serverMessage,
        );
      }
      return true;
    } on ApiError catch (error) {
      onAPIError(error.message);
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<List<ReminderModel>> startPrescription({
    required String dateTime,
    required BuildContext context,
    required ActivePrescriptionModel activePrescriptionModel,
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'start': dateTime,
        'notify': activePrescriptionModel.notify,
      };
      final response = await _api
          .patch(
            Uri.parse('${ConstURLs.drug}${activePrescriptionModel.id}/'),
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: ConstProperties.timeoutDuration));

      if (response == null || response.body.isEmpty) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      final decodedJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode != 200 || decodedJson == null) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      var reminders = decodedJson['reminders'] as List?;
      if (reminders == null) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      final remindersList = (List.generate(
        reminders.length,
        (index) => ReminderModel.fromJson(
          json: reminders[index],
          name: activePrescriptionModel.medicine,
          amount: activePrescriptionModel.fraction,
          prescriptionID: activePrescriptionModel.id,
        ),
      ));
      return (remindersList.isEmpty)
          ? throw ApiError(message: APIErrorMessage().serverMessage)
          : remindersList;
    } on ApiError catch (_) {
      onAPIError();
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      onAPIError();
      debugPrint(e.toString());
    }

    return [];
  }
}
