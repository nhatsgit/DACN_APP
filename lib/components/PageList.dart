import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  final int pageCount;
  final Function(int) onPageChanged; // Callback khi người dùng chọn trang mới

  PaginatedListView({
    required this.pageCount,
    required this.onPageChanged,
  });

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  int _currentPage = 1;

  void _onPageSelected(int page) {
    setState(() {
      _currentPage = page;
    });
    widget.onPageChanged(page);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Danh sách các item
        Expanded(
          child: ListView.builder(
            itemCount: 50, // Số lượng items bạn muốn hiển thị
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item #$index'),
              );
            },
          ),
        ),
        // Thanh điều hướng trang
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.pageCount,
              (index) {
                int page = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _onPageSelected(page),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        page == _currentPage ? Colors.blue : Colors.grey,
                      ),
                    ),
                    child: Text(
                      '$page',
                      style: TextStyle(
                        color:
                            page == _currentPage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
