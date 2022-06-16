import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_med/src/constants/properties.dart';
import 'package:my_med/src/constants/urls.dart';
import 'package:my_med/src/core/apis/core_api_methods.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';
import 'package:my_med/src/modules/drug/models/drug_model.dart';

class DrugAPIs {
  final _api = CoreApi();

  Future<List<DrugModel>> getDrugs({
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse(ConstURLs.drug),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );
      if (response == null) return [];
      final int statusCode = response.statusCode;
      if (statusCode != 200) return [];
      final doctorsList = jsonDecode(response.body) as List;
      return List.generate(doctorsList.length,
          (index) => DrugModel.fromJson(doctorsList[index]));
    } on TimeoutException catch (_) {
      onTimeout;
      debugPrint("Timeout connection!");
    } on SocketException catch (_) {
      onDisconnect;
      debugPrint("No Network");
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<DrugDetailModel?> getDrugDetail({
    required String id,
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse('${ConstURLs.drug}$id/'),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );
      if (response == null) return null;
      final int statusCode = response.statusCode;
      if (statusCode != 200) return null;
      final drugDetailModel = jsonDecode(response.body);
      if (drugDetailModel == null) {
        return null;
      }
      return DrugDetailModel.fromJson(drugDetailModel);
    } on TimeoutException catch (_) {
      onTimeout;
      debugPrint("Timeout connection!");
    } on SocketException catch (_) {
      onDisconnect;
      debugPrint("No Network");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
