
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';

class CoreApi {
  final _client = Client();

  final token = PreferencesService.getToken;

  Future<Response?> get(Uri url, {Map<String, String>? headers}) async {
    if (token == null) return null;
    try {
      return await _client.get(
        url,
        headers: {
          "Authorization": "Token ${token!}",
          "Content-Type": "application/json",
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Response?> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    if (token == null) return null;
    try {
      return await _client.post(
        url,
        body: body,
        headers: {
          "Authorization": "Token ${token!}",
          "Content-Type": "application/json",
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Response?> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    if (token == null) return null;
    try {
      return await _client.patch(
        url,
        body: body,
        headers: {
          "Authorization": "Token ${token!}",
          "Content-Type": "application/json",
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
