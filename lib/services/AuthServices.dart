import 'dart:convert';
import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';

class AuthServices {
  final HttpRequest _customHttpClient;

  AuthServices(this._customHttpClient);

  Future<String> login(String userName, String password) async {
    final endpoint = 'Account/login';
    final body = {
      'userName': userName,
      'password': password,
    };

    final response = await _customHttpClient.post(endpoint, body);

    if (response.statusCode == 200) {
      final jwtToken = response.body;

      return jwtToken;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  Future<UserInfoModel> getMyInfo() async {
    final endpoint = 'Account/me';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UserInfoModel.fromJson(data);
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
