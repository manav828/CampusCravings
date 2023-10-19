import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'getShopItems/shopMainItemsProvaider.dart';
import 'gridShopPage.dart';

class MainItemScreen extends StatefulWidget {
  // const MainItemScreen({Key? key}) : super(key: key);
  MainItemScreen({this.shopName, this.shopId, this.shopUrl});
  String? shopName;
  String? shopId;
  String? shopUrl;
  @override
  State<MainItemScreen> createState() => _MainItemScreenState();
}

class _MainItemScreenState extends State<MainItemScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShopItemsProvaider shopItemsProvaider =
          Provider.of<ShopItemsProvaider>(context, listen: false);
      print('called items');
      // shopItemsProvaider.fatchMainItems(widget.shopId!);
      shopItemsProvaider.listenToShopMainDetails(widget.shopId!);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.shopName!,
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
                          // color: Color(0xFFF1414F),
                          // width: 2.0,
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Consumer<ShopItemsProvaider>(
                builder: (context, shopItemsProvaider, child) {
                  return Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        return GridShopPage(
                          mainItemImage: shopItemsProvaider
                              .getShopItemsList[index].mainImageUrl,
                          mainItemName: shopItemsProvaider
                              .getShopItemsList[index].mainItemName,
                          mainItemId: shopItemsProvaider
                              .getShopItemsList[index].mainItemId,
                          shopName: widget.shopName,
                          shopId: widget.shopId,
                        );
                      },
                      itemCount: shopItemsProvaider.getShopItemsList.length,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
