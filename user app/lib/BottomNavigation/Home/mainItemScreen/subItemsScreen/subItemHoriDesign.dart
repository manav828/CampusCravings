import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Cart/cartList/cartProvaider.dart';

class SubItemHoriDesign extends StatefulWidget {
  // const SubItemHoriDesign({Key? key}) : super(key: key)
  SubItemHoriDesign({
    this.subItemName,
    this.subItemPrice,
    this.subItemId,
    this.shopId,
  });
  String? subItemName;
  double? subItemPrice;
  String? subItemId;
  String? shopId;

  @override
  State<SubItemHoriDesign> createState() => _SubItemHoriDesignState();
}

class _SubItemHoriDesignState extends State<SubItemHoriDesign> {
  bool _isClicked = false;
  String capitalizeFirstWord(String text) {
    if (text == null || text.isEmpty) return '';

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void _showDialog() {
    setState(() {
      _isClicked = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
              'Add items from one shop at a time. No simultaneous orders from different shops.!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('cart page');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.white,
            // color: Color(0xFF5BD2BC),
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
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalizeFirstWord(widget.subItemName!),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF1C1C1C),
                      fontSize: 23,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 130,
                    child: Text(
                      'Biryani, Desserts, Kacchi,Biryani, Desserts, Kacchi',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: 13,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${widget.subItemPrice} ₹',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontSize: 17,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.w400,
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
                  // color: _isClicked ? Color(0XFFFFCC00) : Colors.transparent,
                  borderRadius: BorderRadius.circular(_isClicked ? 20.0 : 25.0),
                ),
                child: IconButton(
                  onPressed: () {
                    final cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    setState(() {
                      _isClicked = !_isClicked;
                    });

                    if (_isClicked) {
                      print('length');
                      print(cartProvider.cartItemsList.length == 0);
                      if (cartProvider.cartItemsList.length == 0) {
                        cartProvider.addToCart(
                          itemName: widget.subItemName,
                          itemPrice: widget.subItemPrice,
                          shopId: widget.shopId,
                          itemId: widget.subItemId,
                        );
                      } else if (widget.shopId ==
                          cartProvider.cartItemsList[0].shopId) {
                        // setState(() {
                        //   _isClicked = !_isClicked;
                        // });
                        cartProvider.addToCart(
                          itemName: widget.subItemName,
                          itemPrice: widget.subItemPrice,
                          shopId: widget.shopId,
                          itemId: widget.subItemId,
                        );
                      } else {
                        _showDialog();

                        print('item from other store');
                      }
                    } else {
                      // setState(() {
                      //   _isClicked = !_isClicked;
                      // });
                      cartProvider.removeToCart(widget.subItemId);
                      print('remove');
                    }
                  },
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
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
