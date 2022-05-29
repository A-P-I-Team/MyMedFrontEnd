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
      final userProfileResponse = jsonDecode(utf8.decode(response.bodyBytes));
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

  Future<bool> changeName({
    required String firstName,
    required String lastName,
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
  }) async {
    try {
      final body = {
        'first_name' : firstName,
        'last_name' : lastName,
      };
      final response = await _api
          .patch(
            Uri.parse(ConstURLs.profile),
            body: json.encode(body),
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
      return true;
    } on ApiError catch (_) {
      onAPIError();
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> changeGender({
    required String gender,
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
  }) async {
    try {
      final body = {
        'gender' : gender,
      };
      final response = await _api
          .patch(
            Uri.parse(ConstURLs.profile),
            body: json.encode(body),
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
      return true;
    } on ApiError catch (_) {
      onAPIError();
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> changeBirthDate({
    required String birthday,
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required VoidCallback onAPIError,
  }) async {
    try {
      final body = {
        'birthdate' : birthday,
      };
      final response = await _api
          .patch(
            Uri.parse(ConstURLs.profile),
            body: json.encode(body),
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
      return true;
    } on ApiError catch (_) {
      onAPIError();
    } on TimeoutException catch (_) {
      onTimeout();
    } on SocketException catch (_) {
      onDisconnect();
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
