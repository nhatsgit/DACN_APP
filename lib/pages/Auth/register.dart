import 'package:ecommerce_app/controllers/RegisterController.dart';
import 'package:ecommerce_app/pages/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng Ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => TextField(
                    onChanged: (value) => controller.userName.value = value,
                    decoration: InputDecoration(
                      labelText: 'UserName',
                      errorText: controller.userNameError.value.isEmpty
                          ? null
                          : controller.userNameError.value,
                    ),
                  )),
              Obx(() => TextField(
                    onChanged: (value) => controller.password.value = value,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: controller.passwordError.value.isEmpty
                          ? null
                          : controller.passwordError.value,
                    ),
                  )),
              TextField(
                onChanged: (value) => controller.fullName.value = value,
                decoration: InputDecoration(labelText: 'FullName'),
              ),
              TextField(
                onChanged: (value) => controller.address.value = value,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              Obx(() => TextField(
                    onChanged: (value) => controller.email.value = value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: controller.emailError.value.isEmpty
                          ? null
                          : controller.emailError.value,
                    ),
                  )),
              Obx(() => TextField(
                    onChanged: (value) => controller.phoneNumber.value = value,
                    decoration: InputDecoration(
                      labelText: 'PhoneNumber',
                      errorText: controller.phoneNumberError.value.isEmpty
                          ? null
                          : controller.phoneNumberError.value,
                    ),
                  )),
              SizedBox(height: 16),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => controller.avatarImage.value != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                FileImage(controller.avatarImage.value!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person),
                          )),
                    TextButton(
                      onPressed: controller.pickImage,
                      child: Text('Chọn Ảnh'),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.register,
                          child: Text(
                            "Đăng kí",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text("Đã có tài khoản"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
