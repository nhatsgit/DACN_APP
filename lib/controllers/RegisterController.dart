import 'dart:io';

import 'package:ecommerce_app/services/AuthServices.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController {
  final userName = ''.obs;
  final password = ''.obs;
  final fullName = ''.obs;
  final address = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final avatarImage = Rx<File?>(null);

  final userNameError = ''.obs;
  final emailError = ''.obs;
  final phoneNumberError = ''.obs;
  final passwordError = ''.obs;

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

    passwordError.value = '';
    if (!RegExp(r'^(?=.*[!@#\$%^&*(),.?":{}|<>])').hasMatch(password.value)) {
      passwordError.value += 'Ít nhất 1 ký tự thường.\n';
    }
    if (!RegExp(r'^(?=.*\d)').hasMatch(password.value)) {
      passwordError.value += 'Ít nhất 1 ký tự số (\'0\'-\'9\').\n';
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(password.value)) {
      passwordError.value += 'Ít nhất 1 ký tự hoa (\'A\'-\'Z\').\n';
    }
    if (password.value.length < 6) {
      passwordError.value = 'Ít nhất 6 ký tự.\n';
    }

    return userNameError.value.isEmpty &&
        emailError.value.isEmpty &&
        phoneNumberError.value.isEmpty &&
        passwordError.value.isEmpty;
  }

  Future<void> register() async {
    if (validateFields()) {
      try {
        bool success = await AuthServices.register(
          userName: userName.value,
          password: password.value,
          fullName: fullName.value,
          address: address.value,
          email: email.value,
          phoneNumber: phoneNumber.value,
          avatarImage: avatarImage.value,
        );

        if (success) {
          Get.snackbar('Success', 'Registration successful');
        } else {
          Get.snackbar('Error', 'Registration failed');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      print('Validation failed');
    }
  }
}
