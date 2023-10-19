class OrderItem {
  String? itemName;
  String? itemId;
  double? itemPrice;

  int? itemQuantity;

  OrderItem({
    this.itemQuantity,
    this.itemName,
    this.itemPrice,
    this.itemId,
  });
}

class PendingOrder {
  String orderId;
  String userId;
  String shopId;
  String orderStatus;
  String orderDate;
  String orderTime;
  double totalAmount;
  String userName;
  String userToken;

  PendingOrder(
      {required this.orderId,
      required this.userId,
      required this.shopId,
      required this.orderStatus,
      required this.orderDate,
      required this.orderTime,
      required this.totalAmount,
      required this.userName,
      required this.userToken});
}
