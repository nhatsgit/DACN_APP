import 'package:ecommerce_app/controllers/FilterDrawerController.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDrawer extends StatefulWidget {
  final List<CategoryModel> categories;

  final Function()? onClearFilters;
  final Function(int? selectedCategoryId, double? minPrice, double? maxPrice)?
      onApplyFilters;

  const FilterDrawer(
      {Key? key,
      this.onClearFilters,
      this.onApplyFilters,
      required this.categories})
      : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final FilterDrawerController controller = Get.put(FilterDrawerController());

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    minPriceController.text = controller.minPrice?.value.toString() ?? '';
    maxPriceController.text = controller.maxPrice?.value.toString() ?? '';
  }

  void _applyFilters() {
    double? minPrice = double.tryParse(minPriceController.text);
    double? maxPrice = double.tryParse(maxPriceController.text);

    if ((minPrice != null && minPrice < 0) ||
        (maxPrice != null && maxPrice < 0)) {
      Get.snackbar(
        'Lỗi',
        'Giá không thể là giá trị âm!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (widget.onApplyFilters != null) {
      widget.onApplyFilters!(
        controller.selectedCategoryId?.value != 0
            ? controller.selectedCategoryId?.value
            : null,
        minPrice,
        maxPrice,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Lọc sản phẩm',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.price_change),
            title: Text('Tầm giá(đ)'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Min',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.minPrice?.value =
                          double.tryParse(value) ?? 0.0;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Max',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.maxPrice?.value =
                          double.tryParse(value) ?? 10000.0;
                    },
                  ),
                ),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.category),
            title: Text('Danh mục'),
          ),
          Column(
            children: [
              RadioListTile<int>(
                value: 0,
                groupValue: controller.selectedCategoryId?.value,
                onChanged: (value) {
                  setState(() {
                    controller.selectedCategoryId?.value = value!;
                  });
                },
                title: Text("Tất cả"),
              ),
              ...widget.categories
                  .map(
                    (category) => RadioListTile<int>(
                      value: category.productCategoryId,
                      groupValue: controller.selectedCategoryId?.value,
                      onChanged: (value) {
                        setState(() {
                          controller.selectedCategoryId?.value = value!;
                        });
                      },
                      title: Text(category.tenLoai),
                    ),
                  )
                  .toList(),
            ],
          ),
          ListTile(
            leading: Icon(Icons.clear),
            title: Text('Clear Filters'),
            onTap: () {
              setState(() {
                controller.selectedCategoryId?.value = 0;
                controller.minPrice?.value = 0.0;
                controller.maxPrice?.value = 10000.0;
              });
              if (widget.onClearFilters != null) {
                widget.onClearFilters!();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed:
                  _applyFilters, // Sử dụng hàm _applyFilters để kiểm tra giá trị
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
