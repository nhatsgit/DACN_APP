import 'package:ecommerce_app/controllers/UserInfoController.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});

  final UserInfoController controller = Get.put(UserInfoController());

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
                    controller:
                        TextEditingController(text: controller.userName.value),
                    decoration: InputDecoration(
                      labelText: 'UserName',
                      errorText: controller.userNameError.value.isEmpty
                          ? null
                          : controller.userNameError.value,
                    ),
                  )),
              Obx(
                () => TextField(
                  onChanged: (value) => controller.fullName.value = value,
                  controller:
                      TextEditingController(text: controller.fullName.value),
                  decoration: InputDecoration(labelText: 'FullName'),
                ),
              ),
              Obx(
                () => TextField(
                  onChanged: (value) => controller.address.value = value,
                  controller:
                      TextEditingController(text: controller.address.value),
                  decoration: InputDecoration(labelText: 'Address'),
                ),
              ),
              Obx(() => TextField(
                    onChanged: (value) => controller.email.value = value,
                    controller:
                        TextEditingController(text: controller.email.value),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: controller.emailError.value.isEmpty
                          ? null
                          : controller.emailError.value,
                    ),
                  )),
              Obx(() => TextField(
                    onChanged: (value) => controller.phoneNumber.value = value,
                    controller: TextEditingController(
                        text: controller.phoneNumber.value),
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
                    Obx(
                      () => controller.avatarImage.value != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  FileImage(controller.avatarImage.value!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: Image.network(
                                  '${ApiConfig.baseUrl}${controller.avatarLink.value}',
                                  width: 100, // Phù hợp với radius * 2
                                  height: 100,
                                  fit: BoxFit
                                      .cover, // Đảm bảo ảnh lấp đầy khung tròn
                                ),
                              ),
                            ),
                    ),
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
                          onPressed: controller.updateInfo,
                          child: Text(
                            "Cập nhật",
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
