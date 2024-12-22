class MyCaculator {
  static double calculateDiscountedPrice(
      double originalPrice, double discountPercent) {
    if (discountPercent < 0 || discountPercent > 100) {
      throw ArgumentError('Discount percent must be between 0 and 100');
    }

    return originalPrice * (1 - discountPercent / 100);
  }
}
