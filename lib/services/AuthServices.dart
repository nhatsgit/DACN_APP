import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<bool> register({
    required String userName,
    required String password,
    required String fullName,
    required String address,
    required String email,
    required String phoneNumber,
    File? avatarImage,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseAPIUrl}Account/register');

      var request = http.MultipartRequest('POST', uri);

      request.fields['userName'] = userName;
      request.fields['password'] = password;
      request.fields['fullName'] = fullName;
      request.fields['avatar'] = fullName;
      request.fields['address'] = address;
      request.fields['email'] = email;
      request.fields['phoneNumber'] = phoneNumber;

      if (avatarImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'avatarImage',
          avatarImage.path,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateUserInfo({
    required String userName,
    required String fullName,
    required String address,
    required String email,
    required String phoneNumber,
    File? avatarImage,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = prefs.getString('jwt') ?? 'null';
      final uri = Uri.parse('${ApiConfig.baseAPIUrl}Account/edit');
      var request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = 'Bearer $jwt';
      request.fields['userName'] = userName;
      request.fields['fullName'] = fullName;
      request.fields['avatar'] = fullName;
      request.fields['address'] = address;
      request.fields['email'] = email;
      request.fields['phoneNumber'] = phoneNumber;

      if (avatarImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'avatarImage',
          avatarImage.path,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        Get.deleteAll();
        Get.offAllNamed('/login');
        throw Exception('Phiên dăng nhập hết hạn');
      } else {
        throw Exception('Failed to update');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
