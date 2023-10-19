import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../FromFirebase/MainItems/mainItemProvaider.dart';

import '../../shop_onbording/bottomSheet/bottomSheet.dart';

// class AddItem extends StatefulWidget {
//   const AddItem({Key? key}) : super(key: key);
//
//   @override
//   State<AddItem> createState() => _AddItemState();
// }
//
// class _AddItemState extends State<AddItem> {
//   String? ItemName;
//
//   // for image uploded on device
//   bool img = false;
//   void updateImageStatus(bool uploaded) {
//     setState(() {
//       img = uploaded;
//     });
//   }
//
//   String? imgpath;
//   void updateImagepath(String uploaded) {
//     setState(() {
//       imgpath = uploaded;
//     });
//   }
//
//   //image uplode to firebase storage
//   String imageUrl = '';
//
//   Future<bool> _uploadImage() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? shopName = prefs.getString('shopName');
//       print('uploding start');
//       print(imgpath);
//       // print(updateImagepath.toString());
//
//       firabase_storage.UploadTask uploadTask;
//       // print(context.read<UserProvaider>().getShopName);
//       firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
//           .ref()
//           // .child('Charusat')
//           .child('Shops')
//           .child(shopName!)
//           .child('/' + ItemName!);
//       uploadTask = ref.putFile(File(imgpath!));
//       await uploadTask.whenComplete(() => null);
//       imageUrl = await ref.getDownloadURL();
//       print('Image URL => ' + imageUrl);
//       print('uploding end');
//
//       return true;
//     } catch (e) {
//       print('not uploded');
//
//       print(e.toString());
//       return false;
//     }
//   }
//
//   //loading animation
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Items"),
//         backgroundColor: Colors.red,
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 20),
//         padding: EdgeInsets.all(15),
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 TextField(
//                   textAlignVertical: TextAlignVertical.bottom,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: Colors.green,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     labelText: "Item Name",
//                     hintText: "Item Name",
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     ItemName = value;
//                     print(ItemName);
//                     //Do something with the user input.
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextButton(
//               onPressed: () {
//                 // MyBottomSheet().showMyBottomSheet(context);
//                 MyBottomSheet(
//                   onImageUpload: updateImageStatus,
//                   filePath: updateImagepath,
//                 ).showMyBottomSheet(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.image_outlined),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   img != true
//                       ? Text('Upload The Item Image')
//                       : Row(
//                           children: [
//                             Text('uploded image : '),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             img == true
//                                 ? Image.file(
//                                     File(imgpath
//                                         .toString()), // Convert the path to a File object
//                                     height: 100,
//                                     width: 100,
//                                   )
//                                 : Text(''),
//                           ],
//                         )
//
//                   // Image.asset(imgpath.toString())
//                   // Image.file(imgpath),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: double.infinity,
//               height: 45,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.yellow.shade700, Colors.yellow.shade500],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.yellow.shade200,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.yellow.shade200,
//                       textStyle: TextStyle(color: Colors.red),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10))),
//                   onPressed: () async {
//                     setState(() {
//                       isLoading = true; // Start the loading animation
//                     });
//
//                     bool isUploded = await _uploadImage();
//                     // bool issend = await sendItemData();
//                     bool issend = await MainItemProvaider()
//                         .sendItemData(ItemName!, imageUrl);
//
//                     if (isUploded && issend) {
//                       Navigator.of(context).pop();
//                       Provider.of<MainItemProvaider>(context, listen: false)
//                           .fatchMainItems();
//                     }
//                     setState(() {
//                       isLoading = false; // Stop the loading animation
//                     });
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Visibility(
//                         visible: !isLoading,
//                         child: Text(
//                           "Add Item",
//                           style: TextStyle(
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: isLoading,
//                         child: CircularProgressIndicator(), // Loading animation
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AddItem extends StatefulWidget {
  // const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  String? itemName;

  bool img = false;
  void updateImageStatus(bool uploaded) {
    setState(() {
      img = uploaded;
    });
  }

  String? imgpath;
  void updateImagepath(String uploaded) {
    setState(() {
      imgpath = uploaded;
    });
  }

  String imageUrl = '';
  String shopName = '';
  _fetch() async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
    print(firebaseUser);

    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser)
          .get()
          .then((ds) {
        shopName = ds.get('ShopName');
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<bool> _uploadImage() async {
    try {
      await _fetch();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print("image uploding start 1");
      firabase_storage.UploadTask uploadTask;
      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('Shops')
          .child(shopName)
          .child('/' + itemName!);
      print("image uploding start 2");

      uploadTask = ref.putFile(File(imgpath!));
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('Image URL => ' + imageUrl);

      return true;
    } catch (e) {
      print('not uploaded');
      print(e.toString());
      return false;
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors
              .red, // Change this color to your preferred background color
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Items"),
          backgroundColor: Colors.red,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        labelText: "Item Name",
                        hintText: "Item Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          itemName = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an item name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    MyBottomSheet(
                      onImageUpload: updateImageStatus,
                      filePath: updateImagepath,
                    ).showMyBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      img != true
                          ? Text('Upload The Item Image')
                          : Row(
                              children: [
                                Text('Uploaded image : '),
                                SizedBox(
                                  width: 10,
                                ),
                                img == true
                                    ? Image.file(
                                        File(imgpath.toString()),
                                        height: 100,
                                        width: 100,
                                      )
                                    : Text(''),
                              ],
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow.shade700, Colors.yellow.shade500],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow.shade200,
                          textStyle: TextStyle(color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        if (!img) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please upload an image')),
                          );
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        bool isUploaded = await _uploadImage();
                        bool isSent = await MainItemProvaider()
                            .sendItemData(itemName!, imageUrl);

                        if (isUploaded && isSent) {
                          Navigator.of(context).pop();
                          Provider.of<MainItemProvaider>(context, listen: false)
                              .fatchMainItems();
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Visibility(
                            visible: !isLoading,
                            child: Text(
                              "Add Item",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isLoading,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
