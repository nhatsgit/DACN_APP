import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/components/custom_button.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(children: [
          Text(
            "Tài khoản",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Spacer(),
          CustomButton(
              onTap: () => {Navigator.pushNamed(context, AppRoutes.login)},
              title: "Đăng nhập")
        ]),
        Expanded(
          child: Container(
            color: Colors.grey[200], // Đặt màu nền xám (có thể thay đổi sắc độ)
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("mycarts"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
