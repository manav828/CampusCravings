import 'dart:ffi';

class SubItemsModel {
  double subItemPrice;
  String subItemName;
  String subItemId;

  SubItemsModel(
      {this.subItemName = '', this.subItemPrice = 0, this.subItemId = ''});
}
