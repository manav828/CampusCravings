// import 'package:charueats_delivery/BottomNavigation/Home/mainItemScreen/subItemsScreen/subItemsScreen.dart';
import 'package:campus_craving_admin/bottomNavigation/shopOnbording/Home/mainItemScreen/subItemsScreen/subItemsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'getShopItems/shopMainItemsProvaider.dart';

class GridShopPage extends StatefulWidget {
  // const GridShopPage({Key? key}) : super(key: key);
  GridShopPage({this.mainItemName, this.mainItemImage, this.mainItemId,this.shopName,this.shopId});
  String? mainItemImage;
  String? mainItemId;
  String? mainItemName;
  String? shopName;
  String? shopId;
  @override
  State<GridShopPage> createState() => _GridShopPageState();
}

class _GridShopPageState extends State<GridShopPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   ShopItemsProvaider shopItemsProvaider =
    //       Provider.of<ShopItemsProvaider>(context, listen: false);
    //   print('called items');
    //   shopItemsProvaider.fatchMainItems(widget.mainItemId!);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 20,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ]),
      child: InkWell(
        onTap: () {
          print(widget.mainItemId);
          print(widget.mainItemName);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => SubItemsScreen(
                shopUrl: widget.mainItemImage,
                mainItemId: widget.mainItemId,
                mainItemName: widget.mainItemName,
                shopName: widget.shopName,
                shopId: widget.shopId,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 140,
              width: double.maxFinite,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.mainItemImage!),
                  // image: AssetImage('assets/main.avif'),
                  fit: BoxFit.fill,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(widget.mainItemName!),
            )
          ],
        ),
      ),
    );
  }
}
