import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/components/custom_button.dart';
import 'package:ecommerce_app/pages/Account/Myaccount.dart';
import 'package:ecommerce_app/pages/Auth/login.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/icons/logo.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Tên: ádasdaf",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.home, color: Colors.orange),
                    title: Text("Home"),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.home),
                  ),
                  Divider(height: 1),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.shopping_cart, color: Colors.orange),
                    title: Text("Giỏ hàng"),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.cart),
                  ),
                  Divider(height: 1),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.app_registration_sharp,
                        color: Colors.orange),
                    title: Text("Đơn hàng"),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.order),
                  ),
                  Divider(height: 1),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.settings, color: Colors.orange),
                    title: Text("Tài khoản"),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAccountPage()),
                    ),
                  ),
                  Divider(height: 1),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.output, color: Colors.red),
                    title: Text(
                      "Đăng xuất",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
