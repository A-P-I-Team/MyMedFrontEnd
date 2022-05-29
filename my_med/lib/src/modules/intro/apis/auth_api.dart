import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/constants/properties.dart';
import 'package:my_med/src/constants/urls.dart';
import 'package:my_med/src/modules/intro/models/city_model.dart';
import 'package:my_med/src/modules/intro/models/user_model.dart';

class AuthAPI {
  Future<bool> login({
    required String email,
    required String password,
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ConstURLs.login),
        body: {
          'username': email,
          'password': password,
        },
      ).timeout(
        const Duration(
          seconds: ConstProperties.timeoutDuration,
        ),
      );
      final body = jsonDecode(response.body);
      final int statusCode = response.statusCode;
      if (statusCode != 200) return false;
      if (body.containsKey('token') == false) return false;
      final String? token = body['token'];
      if (token == null) return false;
      PreferencesService.setTokens(token: token);
      return true;
    } on TimeoutException catch (_) {
      onTimeout;
      debugPrint("Timeout connection!");
      return false;
    } on SocketException catch (_) {
      onDisconnect;
      debugPrint("No Network");
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<int?> verifyEmailAccountWithOTP({required String email, VoidCallback? onTimeout, VoidCallback? onDisconnect, bool resetPassword = false,}) async {
    try {
      final body = (resetPassword == false) ? {
          'email': email,
          'name': email,
        } : {
          'email': email,
        };
      final response = await http.post(
        Uri.parse((resetPassword) ? ConstURLs.forgetPasswordEmail : ConstURLs.sendRegisterEmail),
        body: body,
      );
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final int statusCode = response.statusCode;
      if (statusCode != 200) return null;
      if (responseBody.containsKey('code') == false) return null;
      final int otpCode = responseBody['code'];
      return otpCode;
    } on TimeoutException catch (_) {
      onTimeout;
      debugPrint("Timeout connection!");
      return null;
    } on SocketException catch (_) {
      onDisconnect;
      debugPrint("No Network");
      return null;
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String ssn,
    required String gender,
    required String birthday,
    required String userCityID,
    required File profilePicFile,
    required String relationshipStatus,
    required String isVaccinated,
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final UserModel newUser = UserModel(
        username: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        ssn: ssn,
        gender: UserModel.getGender(gender),
        birthdate: birthday,
        userCityID: userCityID,
        isVaccinated: isVaccinated,
        relationshipStatus: relationshipStatus,
      );

      var request = http.MultipartRequest("POST", Uri.parse(ConstURLs.register));
      var pic = await http.MultipartFile.fromPath("profile_pic", profilePicFile.path).timeout(
        const Duration(seconds: ConstProperties.timeoutDuration),
      );
      request.files.add(pic);
      request.fields.addAll(newUser.toJson());
      var response = await request.send().timeout(const Duration(seconds: ConstProperties.timeoutDuration));

      final int statusCode = response.statusCode;
      if (statusCode != 201) return false;
      return true;
    } on TimeoutException catch (_) {
      onTimeout;
      debugPrint("Timeout connection!");
      return false;
    } on SocketException catch (_) {
      onDisconnect;
      debugPrint("No Network");
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<CityModel>> getCities({VoidCallback? onTimeout, VoidCallback? onDisconnect}) async {
    try {
      final response = await http.get(
        Uri.parse(ConstURLs.cities),
      );
      final cityListResponse = jsonDecode(response.body) as List;
      final int statusCode = response.statusCode;
      if (statusCode != 200) return [];
      return List.generate(cityListResponse.length, (index) => CityModel.fromJson(cityListResponse[index]));
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

   Future<bool> setNewPassword({
    required String password,
    required String confirmPassword,
    required String email,
    required VoidCallback onTimeout,
    required VoidCallback onDisconnect,
    required void Function(String message) onAPIError,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(ConstURLs.forgetPassword),
        body: {
          'new_password1': password,
          'new_password2': confirmPassword,
          'email' : email,
        },
      ).timeout(
        const Duration(
          seconds: ConstProperties.timeoutDuration,
        ),
      );
      final int statusCode = response.statusCode;
      final responseBody = json.decode(utf8.decode(response.bodyBytes)) as Map?;
      if (statusCode == 400  && responseBody != null && responseBody.containsKey("non_field_errors")) {
        throw ApiError(message: responseBody["non_field_errors"][0]);
      }
      if (statusCode != 200) throw ApiError(message: APIErrorMessage().serverMessage);
      return true;
    } on TimeoutException catch (_) {
      onTimeout();
      return false;
    } on SocketException catch (_) {
      onDisconnect();
      return false;
    }
    on ApiError catch (e) {
      onAPIError(e.message);
      return false;
    }
     catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  
}
