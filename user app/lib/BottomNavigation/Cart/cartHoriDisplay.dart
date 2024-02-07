import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartList/cartProvaider.dart';

class CartHoriDisplay extends StatefulWidget {
  // const CartHoriDisplay({Key? key}) : super(key: key);
  CartHoriDisplay(
      {this.subItemName,
      this.subItemPrice,
      this.subItemId,
      this.shopId,
      this.itemQuantity,
      this.itemTotalPrice});
  String? subItemName;
  double? subItemPrice;
  String? subItemId;
  String? shopId;
  int? itemQuantity;
  double? itemTotalPrice;

  @override
  State<CartHoriDisplay> createState() => _CartHoriDisplayState();
}

class _CartHoriDisplayState extends State<CartHoriDisplay> {
  bool _isClicked = false;
  String capitalizeFirstWord(String text) {
    if (text == null || text.isEmpty) return '';

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  int itemCount = 0;
  CartProvider? cartProvider;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of(context);

    print('cart page');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
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
        // height: 80,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      // capitalizeFirstWord(widget.subItemName!),
                      capitalizeFirstWord('${widget.subItemName!}'),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontSize: 21,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    // '${widget.subItemPrice}\$',
                    '${widget.subItemPrice}\$',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF4F4F4F),
                      fontSize: 17,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // IconButton(
                  //   onPressed: decrementItem,
                  //   icon: Icon(
                  //     Icons.remove,
                  //   ),
                  // ),
                  Consumer<CartProvider>(
                    // Use Consumer to listen for changes in CartProvider
                    builder: (context, cartProvider, _) {
                      return IconButton(
                        onPressed: () {
                          if (widget.itemQuantity! > 1) {
                            cartProvider.decrementItem(widget.subItemId!);
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                        ),
                      );
                    },
                  ),
                  Text("${widget.itemQuantity}"),
                  Consumer<CartProvider>(
                    // Use Consumer to listen for changes in CartProvider
                    builder: (context, cartProvider, _) {
                      return IconButton(
                        onPressed: () {
                          cartProvider.incrementItem(widget.subItemId!);
                        },
                        icon: Icon(
                          Icons.add,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: _isClicked ? 40.0 : 50.0,
                height: _isClicked ? 40.0 : 50.0,
                decoration: BoxDecoration(
                  color: _isClicked ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(_isClicked ? 20.0 : 25.0),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _isClicked = !_isClicked;
                    });
                    final cartProvider =
                        Provider.of<CartProvider>(context, listen: false);

                    cartProvider.removeToCart(widget.subItemId);
                    print('remove');
                  },
                  icon: Icon(
                    Icons.delete,
                    color: _isClicked ? Colors.white : Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
        // color: Colors.grey.shade100,
      ),
    );
  }
}
