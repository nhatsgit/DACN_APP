import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpClient {
  final http.Client _client;
  final BuildContext context;

  CustomHttpClient(this._client, this.context);

  Future<http.Response> get(String endpoint) async {
    final token = await _getJwt();

    final url = Uri.parse('${ApiConfig.baseAPIUrl}$endpoint');
    final response = await _client.get(
      url,
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );
    return _handleResponse(response);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final token = await _getJwt();
    final url = Uri.parse('${ApiConfig.baseAPIUrl}$endpoint');
    final response = await _client.post(
      url,
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response);
  }

  Future<String?> _getJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      await _logout();
      _redirectToLogin();
    }
    return response;
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }

  void _redirectToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
