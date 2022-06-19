import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_med/src/constants/properties.dart';
import 'package:my_med/src/constants/urls.dart';
import 'package:my_med/src/core/apis/core_api_methods.dart';
import 'package:my_med/src/modules/doctor/models/doctor_detail_model.dart';
import 'package:my_med/src/modules/doctor/models/doctor_model.dart';

class DoctorAPIs {
  final _api = CoreApi();

  Future<List<DoctorModel>> getDoctors({
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse(ConstURLs.doctor),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );
      if (response == null) return [];
      final doctorsList = jsonDecode(response.body) as List;
      final int statusCode = response.statusCode;
      if (statusCode != 200) return [];
      return List.generate(doctorsList.length,
          (index) => DoctorModel.fromJson(doctorsList[index]));
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

  Future<DoctorDetailModel?> getDoctorDetails({
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
    required String id,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse(ConstURLs.doctorDetail + id),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );
      if (response == null) return null;
      final doctorDetail = jsonDecode(response.body);
      final int statusCode = response.statusCode;
      if (statusCode != 200) return null;
      return DoctorDetailModel.fromJson(doctorDetail);
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
