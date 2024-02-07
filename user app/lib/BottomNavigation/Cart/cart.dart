import 'package:charueats_delivery/BottomNavigation/Home/mainItemScreen/subItemsScreen/subItemHoriDesign.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartHoriDisplay.dart';
import 'cartList/cartProvaider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  // CartScreen(
  //     {this.shopUrl,
  //     this.shopName,
  //     this.mainItemId,
  //     this.mainItemName,
  //     this.shopId});
  // String? shopName;
  // String? shopUrl;
  // String? mainItemName;
  // String? mainItemId;
  // String? shopId;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);

      cartProvider.fatchCartData();

      print('fatching data /////cart///// item dart');
    });
  }

  CartProvider? cartProvider;
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    double cartTotal = cartProvider!.getCartTotal();

    return Scaffold(
      backgroundColor: Color(0xfff3f5f7),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, left: 10, right: 10, bottom: 30),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Cart - ...',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(100)),
              //     border: Border.all(
              //       color: Color(0xFFF1414F),
              //       width: 2.0,
              //     ),
              //   ),
              //   child: ClipOval(
              //     child: Image.network(
              //       '',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
            ]),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, right: 15, left: 15),
                    child: cartProvider!.getCartItemList.length == 0
                        ? Text(
                            "Add item now", // Replace this with your interesting text
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        : Column(
                            children: cartProvider!.getCartItemList.map((e) {
                              return CartHoriDisplay(
                                shopId: e.shopId,
                                subItemPrice: e.price,
                                subItemName: e.itemName,
                                subItemId: e.itemId,
                                itemQuantity: e.itemQuantity,
                              );
                            }).toList(),
                          ),
                  ),
                  Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Cart Total : ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration
                                .underline, // add an underline decoration
                          ),
                        ),
                        Text(
                          cartTotal.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration
                                .underline, // add an underline decoration
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.shade800,
                                Colors.grey.shade600,
                                // Colors.grey,
                              ],
                            ),
                          ),
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                cartProvider!.addOrderToPendingOrders();
                              },
                              child: Text('Place Order'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // make the button background transparent
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
