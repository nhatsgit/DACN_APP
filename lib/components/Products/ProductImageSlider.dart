import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final String? anhDaiDien;
  final List<String> imageUrls;

  const ProductImageSlider(
      {super.key, required this.anhDaiDien, required this.imageUrls});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    final totalImages = 1 + widget.imageUrls.length;

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < totalImages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalImages = 1 + widget.imageUrls.length;

    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: totalImages,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: widget.anhDaiDien != null
                  ? Image.network(
                      widget.anhDaiDien!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.image, size: 200)),
                    )
                  : const Center(child: Icon(Icons.image, size: 50)),
            );
          } else {
            final imageUrl = widget.imageUrls[index - 1];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.image, size: 200)),
              ),
            );
          }
        },
      ),
    );
  }
}
