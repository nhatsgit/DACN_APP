import 'package:get/get.dart';

class MainPageController extends GetxController {
  var selectedIndex = 0.obs; // Quản lý trạng thái chỉ số được chọn

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
