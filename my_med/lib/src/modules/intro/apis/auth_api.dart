import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<int?> verifyEmailAccountWithOTP({required String email, VoidCallback? onTimeout, VoidCallback? onDisconnect}) async {
    try {
      final response = await http.post(
        Uri.parse(ConstURLs.sendRegisterEmail),
        body: {
          'email': email,
          'name': email,
        },
      );
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final int statusCode = response.statusCode;
      if (statusCode != 200) return null;
      if (body.containsKey('code') == false) return null;
      final int otpCode = body['code'];
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
    VoidCallback? onTimeout,
    VoidCallback? onDisconnect,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(ConstURLs.login),
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
}
