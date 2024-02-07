class CartModel {
  String? itemName;
  String? itemId;
  double? price;
  String? shopId;
  int itemQuantity;
  double? itemTotalPrice;

  CartModel(
      {this.shopId,
      this.itemQuantity = 1,
      this.itemName,
      this.price,
      this.itemId,
      this.itemTotalPrice});
}
