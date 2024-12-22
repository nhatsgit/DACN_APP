import 'package:get/get.dart';

class FilterDrawerController extends GetxController {
  RxInt? selectedCategoryId = RxInt(0);
  RxDouble? minPrice = RxDouble(0.0);
  RxDouble? maxPrice = RxDouble(100000000.0);
}
