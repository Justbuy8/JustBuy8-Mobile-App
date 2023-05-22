class ProductDiscount {
  static double getDiscountByPercentage(double price, double discount) {
    return price - (price * discount / 100);
  }

  static double getDiscountByFlat(double price, double discount) {
    return price - discount;
  }
}
