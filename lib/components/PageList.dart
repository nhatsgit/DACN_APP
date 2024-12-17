import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  final int pageCount; // Tổng số trang
  final int currentPage; // Trang hiện tại
  final Function(int) onPageChanged; // Callback khi người dùng chọn trang mới

  const PaginatedListView({
    super.key,
    required this.pageCount,
    required this.onPageChanged,
    required this.currentPage,
  });

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  // Xử lý khi chọn trang
  void _onPageSelected(int page) {
    if (page >= 1 && page <= widget.pageCount) {
      widget.onPageChanged(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Nút chuyển về trang trước
        _buildSquareButton(
          text: '<',
          onPressed: widget.currentPage > 1
              ? () => _onPageSelected(widget.currentPage - 1)
              : null,
        ),

        // Hiển thị danh sách nút trang
        ..._buildPageButtons(),

        // Nút chuyển sang trang tiếp theo
        _buildSquareButton(
          text: '>',
          onPressed: widget.currentPage < widget.pageCount
              ? () => _onPageSelected(widget.currentPage + 1)
              : null,
        ),
      ],
    );
  }

  // Hàm xây dựng danh sách các nút trang
  List<Widget> _buildPageButtons() {
    List<Widget> buttons = [];
    if (widget.pageCount <= 8) {
      // Hiển thị tất cả các trang nếu số trang <= 8
      for (int i = 1; i <= widget.pageCount; i++) {
        buttons.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _buildSquareButton(
              text: i.toString(),
              isSelected: i == widget.currentPage,
              onPressed: () => _onPageSelected(i),
            ),
          ),
        );
      }
    } else {
      // Nếu có nhiều hơn 8 trang, hiển thị 3 trang đầu, 3 trang cuối và "..."
      buttons.add(_buildSquareButton(
        text: '1',
        isSelected: 1 == widget.currentPage,
        onPressed: () => _onPageSelected(1),
      ));
      buttons.add(_buildSquareButton(
        text: '2',
        isSelected: 2 == widget.currentPage,
        onPressed: () => _onPageSelected(2),
      ));
      buttons.add(_buildSquareButton(
        text: '3',
        isSelected: 3 == widget.currentPage,
        onPressed: () => _onPageSelected(3),
      ));
      if (widget.currentPage > 3 &&
          widget.currentPage <= widget.pageCount - 3) {
        buttons.add(_buildSquareButton(
          text: widget.currentPage.toString(),
          isSelected: widget.currentPage == widget.currentPage,
          onPressed: () => _onPageSelected(3),
        ));
      }
      buttons.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
          '...',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ));
      buttons.add(_buildSquareButton(
        text: (widget.pageCount - 2).toString(),
        isSelected: (widget.pageCount - 2) == widget.currentPage,
        onPressed: () => _onPageSelected(widget.pageCount - 2),
      ));
      buttons.add(_buildSquareButton(
        text: (widget.pageCount - 1).toString(),
        isSelected: (widget.pageCount - 1) == widget.currentPage,
        onPressed: () => _onPageSelected(widget.pageCount - 1),
      ));
      buttons.add(_buildSquareButton(
        text: widget.pageCount.toString(),
        isSelected: widget.pageCount == widget.currentPage,
        onPressed: () => _onPageSelected(widget.pageCount),
      ));
    }
    return buttons;
  }

  // Hàm tạo button hình vuông
  Widget _buildSquareButton({
    required String text,
    bool isSelected = false,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.orange : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Không bo góc
          ),
          padding: EdgeInsets.zero, // Loại bỏ padding mặc định
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
