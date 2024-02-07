import 'package:charueats_delivery/BottomNavigation/Home/mainItemScreen/subItemsScreen/subItemHoriDesign.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'getShopSubItems/shopSubItemProvaider.dart';

class SubItemsScreen extends StatefulWidget {
  // const SubItemsScreen({Key? key}) : super(key: key);
  SubItemsScreen(
      {this.shopUrl,
      this.shopName,
      this.mainItemId,
      this.mainItemName,
      this.shopId});
  String? shopName;
  String? shopUrl;
  String? mainItemName;
  String? mainItemId;
  String? shopId;

  @override
  State<SubItemsScreen> createState() => _SubItemsScreenState();
}

class _SubItemsScreenState extends State<SubItemsScreen> {
  ShopSubItemProvaider? shopSubItemProvaider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShopSubItemProvaider shopSubItemProvaider =
          Provider.of<ShopSubItemProvaider>(context, listen: false);
      // shopSubItemProvaider.fatchSubItems(
      //     shopId: widget.shopId!, mainItemId: widget.mainItemId!);
      shopSubItemProvaider.listenToShopSubItem(
          shopId: widget.shopId!, mainItemId: widget.mainItemId!);
      // shopSubItemProvaider?.listenToShopDetails();
      print('fatching data sub item dart');
    });
  }

  @override
  Widget build(BuildContext context) {
    shopSubItemProvaider = Provider.of<ShopSubItemProvaider>(context);

    return Scaffold(
      backgroundColor: Color(0xfff3f5f7),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      color: Color(0xFFF1414F),
                    ),
                  ),
                  Text(
                    '${widget.shopName} - ${widget.mainItemName}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                        color: Color(0xFFF1414F),
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.shopUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35, right: 15, left: 15),
            child: Column(
              children: shopSubItemProvaider!.subItemList.map((e) {
                return SubItemHoriDesign(
                  subItemId: e.shopSubItemId,
                  subItemName: e.shopSubItemName,
                  subItemPrice: e.shopSubItemPrice,
                  shopId: widget.shopId,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
