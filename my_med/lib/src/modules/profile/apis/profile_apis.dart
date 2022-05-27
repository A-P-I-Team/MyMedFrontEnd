import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/constants/properties.dart';
import 'package:my_med/src/constants/urls.dart';
import 'package:my_med/src/core/apis/core_api_methods.dart';
import 'package:my_med/src/modules/profile/models/profile_model.dart';

class ProfileAPI {
  final _api = CoreApi();

  Future<UserProfileModel?> getUserProfile({
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
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
      if (response == null) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }

      if (response.statusCode != 200) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      final userProfileResponse = jsonDecode(response.body);
      if (userProfileResponse == null) {
        throw ApiError(message: APIErrorMessage().serverMessage);
      }
      return UserProfileModel.fromJson(userProfileResponse);
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
}
