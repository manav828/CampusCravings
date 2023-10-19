// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../mainItemScreen/mainItemScreen.dart';
// import '../shopDetails/shopProvaider.dart';
//
// class ShopDesign extends StatefulWidget {
//   // const ShopDesign({Key? key}) : super(key: key);
//   ShopDesign({this.shopName, this.shopUrl, this.id, this.adminPermission});
//   String? shopName;
//   String? id = "";
//   String? shopUrl;
//   bool? adminPermission;
//
//   @override
//   State<ShopDesign> createState() => _ShopDesignState();
// }
//
// class _ShopDesignState extends State<ShopDesign> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       ShopProvaider subItemProvaider =
//           Provider.of<ShopProvaider>(context, listen: false);
//       subItemProvaider.fatchShopDeatils();
//     });
//   }
//
//   bool fillColour = false;
//
//   void changeColour() {
//     if (fillColour == false) {
//       fillColour = true;
//     } else {
//       fillColour = false;
//     }
//   }
//
//   late ShopProvaider shopUpdate;
//   @override
//   Widget build(BuildContext context) {
//     print('build');
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           CupertinoPageRoute(
//             builder: (context) => MainItemScreen(
//               shopName: widget.shopName,
//               shopId: widget.id,
//               shopUrl: widget.shopUrl,
//             ),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: 384,
//           height: 290,
//           decoration: ShapeDecoration(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               shadows: [
//                 BoxShadow(
//                   color: Color(0x0C000000),
//                   blurRadius: 20,
//                   offset: Offset(0, 2),
//                   spreadRadius: 0,
//                 ),
//               ]),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     // width: 200,
//                     height: 210,
//                     decoration: ShapeDecoration(
//                       image: DecorationImage(
//                         // image: NetworkImage(widget.shopUrl!),
//                         image: NetworkImage(widget.shopUrl!),
//                         fit: BoxFit.fill,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(24),
//                           topLeft: Radius.circular(24),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             changeColour();
//                           });
//                         },
//                         icon: fillColour == false
//                             ? Icon(
//                                 Icons.favorite_border,
//                                 color: Colors.white,
//                               )
//                             : Icon(
//                                 Icons.favorite,
//                                 color: Colors.white,
//                               ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10.0, left: 10),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             widget.shopName!,
//                             // 'Charusat',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Color(0xFF1C1C1C),
//                               fontSize: 23,
//                               fontFamily: 'Metropolis',
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0, left: 10),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Biryani, Desserts, Kacchi',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Color(0xFF4F4F4F),
//                               fontSize: 13,
//                               fontFamily: 'Metropolis',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10.0),
//                     child: Transform.scale(
//                       scale: 1.5,
//                       child: Switch(
//                         value: widget.adminPermission!,
//                         onChanged: (newValue) {
//                           if (widget.adminPermission! == true) {
//                             shopUpdate.updateAdminPremission(
//                                 widget.id, widget.adminPermission!);
//                             // _updateShopStatus(newValue);
//                           } else {
//                             shopUpdate.updateAdminPremission(
//                                 widget.id, widget.adminPermission!);
//                             // Show a dialog when admin permission is false
//                           }
//                         }, // Disable switch if adminPermission is false
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../mainItemScreen/mainItemScreen.dart';
import '../shopDetails/shopProvaider.dart';

class ShopDesign extends StatefulWidget {
  ShopDesign({this.shopName, this.shopUrl, this.id, this.adminPermission});

  String? shopName;
  String? id = "";
  String? shopUrl;
  bool? adminPermission;

  @override
  State<ShopDesign> createState() => _ShopDesignState();
}

class _ShopDesignState extends State<ShopDesign> {
  // Initialize shopUpdate with an instance of ShopProvaider
  late ShopProvaider shopProvaider = ShopProvaider();

  @override
  void initState() {
    super.initState();

    shopProvaider = Provider.of<ShopProvaider>(context, listen: false);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      shopProvaider.listenToShopDetails();
      print('fetching data main dart');
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

  bool? isApproved;
  @override
  Widget build(BuildContext context) {
    // Set isApproved based on widget.adminPermission
    isApproved = widget.adminPermission ?? false;
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
                    height: 210,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.shopUrl!),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.shopName!,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        value: isApproved!,
                        onChanged: (newValue) {
                          if (widget.adminPermission! == true) {
                            setState(() {
                              isApproved = newValue;
                              shopProvaider.updateAdminPremission(
                                  widget.id, newValue);
                            });
                          } else {
                            setState(() {
                              isApproved = newValue;
                              shopProvaider.updateAdminPremission(
                                  widget.id, newValue);
                            });

                            // Show a dialog when admin permission is false
                          }
                        }, // Disable switch if adminPermission is false
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
