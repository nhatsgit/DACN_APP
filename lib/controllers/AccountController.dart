import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/pages/Auth/login.dart';
import 'package:ecommerce_app/pages/Home/HomePage.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/services/AuthServices.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  var userInfo = Rx<UserInfoModel?>(null);
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
      userInfo.value = user;
    } catch (e) {
      errorMessage.value = 'Lỗi khi lấy thông tin: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    Get.offAll(() => MainPage());
    Get.to(() => LoginPage());
  }
}
