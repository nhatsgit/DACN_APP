import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/services/AuthServices.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AccountController extends GetxController {
  var userInfo = Rx<UserInfoModel?>(null); // Rx để lưu dữ liệu UserInfoModel
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo(); // Gọi hàm fetch khi controller khởi tạo
  }

  Future<void> fetchUserInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Xóa thông báo lỗi cũ
      final user =
          await AuthServices(CustomHttpClient(http.Client())).getMyInfo();
      userInfo.value = user; // Cập nhật dữ liệu người dùng
    } catch (e) {
      errorMessage.value = 'Lỗi khi lấy thông tin: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
