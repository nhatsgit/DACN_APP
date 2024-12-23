import 'dart:io';
import 'package:ecommerce_app/controllers/AccountController.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';

import 'package:ecommerce_app/services/AuthServices.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserInfoController extends GetxController {
  final userName = ''.obs;
  final fullName = ''.obs;
  final address = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final avatarLink = ''.obs;
  final avatarImage = Rx<File?>(null);
  final userNameError = ''.obs;
  final emailError = ''.obs;
  final phoneNumberError = ''.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final user = await AuthServices(HttpRequest(http.Client())).getMyInfo();
      userName.value = user.userName;
      fullName.value = user.fullName;
      address.value = user.address;
      email.value = user.email;
      phoneNumber.value = user.phoneNumber;
      avatarLink.value = user.avatar;
    } catch (e) {
      errorMessage.value = 'Lỗi khi lấy thông tin: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      avatarImage.value = File(pickedFile.path);
    }
  }

  bool validateFields() {
    userNameError.value = userName.value.isEmpty
        ? 'UserName is required'
        : (RegExp(r'^[a-zA-Z0-9]{8,}$').hasMatch(userName.value)
            ? ''
            : 'Ký tự dài ít nhất 8 ký tự');

    emailError.value =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                .hasMatch(email.value)
            ? ''
            : 'Email không hợp lệ';

    phoneNumberError.value = RegExp(r'^\d{10,15}$').hasMatch(phoneNumber.value)
        ? ''
        : 'SDT không hợp lệ';

    return userNameError.value.isEmpty &&
        emailError.value.isEmpty &&
        phoneNumberError.value.isEmpty;
  }

  Future<void> updateInfo() async {
    if (validateFields()) {
      try {
        bool success = await AuthServices.updateUserInfo(
          userName: userName.value,
          fullName: fullName.value,
          address: address.value,
          email: email.value,
          phoneNumber: phoneNumber.value,
          avatarImage: avatarImage.value,
        );
        if (success) {
          Get.delete<AccountController>();
          Get.offAll(() => MainPage());
          Get.snackbar('Success', 'Cập nhật thành công');
        } else {
          Get.snackbar('Error', 'Cập nhât thất bại');
        }
      } catch (e) {
        Get.snackbar('Error', 'Đã lỗi: $e');
      }
    } else {
      print('Validation failed');
    }
  }
}
