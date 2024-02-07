class OrderHistoryItem {
  String? itemName;
  String? itemId;
  double? itemPrice;
  int? itemQuantity;

  OrderHistoryItem({
    this.itemQuantity,
    this.itemName,
    this.itemPrice,
    this.itemId,
  });
}

class ConformedOrder {
  String orderId;
  String userId;
  String shopId;
  String orderStatus;
  String orderDate;
  String orderTime;
  double totalAmount;
  String userName;
  String shopName;
  List<OrderHistoryItem> orderItemsList;

  ConformedOrder({
    required this.orderId,
    required this.userId,
    required this.shopId,
    required this.orderStatus,
    required this.orderDate,
    required this.orderTime,
    required this.totalAmount,
    required this.userName,
    required this.orderItemsList,
    required this.shopName
  });
}
