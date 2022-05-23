import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_med/src/constants/properties.dart';
import 'package:my_med/src/constants/urls.dart';
import 'package:my_med/src/core/apis/core_api_methods.dart';

class ProfileAPI {
  final _api = CoreApi();

  Future<List> getUserProfile({
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final response = await _api
          .get(
            Uri.parse(ConstURLs.profile),
          )
          .timeout(
            const Duration(
              seconds: ConstProperties.timeoutDuration,
            ),
          );
      if (response == null) return [];
      final temp = jsonDecode(response.body) as List;
      final int statusCode = response.statusCode;
      if (statusCode != 200) return [];
      return [];
    } on TimeoutException catch (_) {
      onTimeout;
      debugPrint("Timeout connection!");
      return [];
    } on SocketException catch (_) {
      onDisconnect;
      debugPrint("No Network");
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
