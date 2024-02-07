import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase/shopDetails/shopProvaider.dart';

import '../mainItemScreen/mainItemScreen.dart';

class ShopDesign extends StatefulWidget {
  // const ShopDesign({Key? key}) : super(key: key);
  ShopDesign({this.shopName, this.shopUrl, this.id});
  String? shopName;
  String? id;
  String? shopUrl;

  @override
  State<ShopDesign> createState() => _ShopDesignState();
}

class _ShopDesignState extends State<ShopDesign> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShopProvaider subItemProvaider =
          Provider.of<ShopProvaider>(context, listen: false);
      subItemProvaider.fatchShopDeatils();
    });
  }

  bool fillColour = false;

  void changeColour() {
    if (fillColour == false) {
      fillColour = true;
    } else {
      fillColour = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MainItemScreen(
              shopName: widget.shopName,
              shopId: widget.id,
              shopUrl: widget.shopUrl,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 384,
          height: 290,
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
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // width: 200,
                    height: 210,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        // image: NetworkImage(widget.shopUrl!),
                        image: AssetImage('assets/main.avif'),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            changeColour();
                          });
                        },
                        icon: fillColour == false
                            ? Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.shopName!,
                    // 'Charusat',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF1C1C1C),
                      fontSize: 23,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Biryani, Desserts, Kacchi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4F4F4F),
                      fontSize: 13,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
