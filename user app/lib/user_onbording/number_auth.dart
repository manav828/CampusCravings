import 'package:charueats_delivery/user_onbording/user_provaider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'image_upload/image_selector.dart';

class Number_Auth extends StatefulWidget {
  Number_Auth({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<Number_Auth> createState() => _Number_AuthState();
}

class _Number_AuthState extends State<Number_Auth> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? User_Name;
  // bool? image = MyBottomSheet().imageUploded;

  String? OwnerName;
  bool img = false;
  String? imgpath;
  void updateImageStatus(bool uploaded) {
    setState(() {
      img = uploaded;
    });
  }

  void updateImagepath(String uploaded) {
    setState(() {
      imgpath = uploaded;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('phone');

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo2.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 25,
                ),
                // Text(
                //   "Phone Verification",
                //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "We need to register your phone without getting started!",
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(
                //   height: 30,
                // ),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Shop Name.';
                    }
                    return null;
                  },
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
                    hintText: "User Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    User_Name = value;
                    //Do something with the user input.
                  },
                ),

                // Container(
                //   height: 50,
                //   child: TextField(
                //     textAlignVertical: TextAlignVertical.bottom,
                //     style: TextStyle(color: Colors.black),
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide(
                //           color: Colors.green,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide(
                //           color: Colors.black,
                //         ),
                //       ),
                //       hintText: "Owner Name",
                //       hintStyle: TextStyle(color: Colors.grey),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       OwnerName = value;
                //       //Do something with the user input.
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    // MyBottomSheet().showMyBottomSheet(context);
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
                          ? Text('Upload The Your Image')
                          : Text('uploded'),
                      // Image.asset(imgpath.toString())
                      // Image.file(imgpath),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                img == true
                    ? Image.file(
                        File(imgpath
                            .toString()), // Convert the path to a File object
                        height: 50,
                        width: 50,
                      )
                    : Text(''),
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
                      gradient: LinearGradient(
                        colors: [
                          // Color(0xFFFF5900),
                          // Color(0xFFFFCC00),
                          Color(0xFF5BD2BC),
                          // Color(0xFFD6C37F),
                          // Color(0xFFB38F4C),
                          // Color(0xFFD6C37F),
                        ],
                        stops: [1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          // setState(() {
                          //   Provider.of<UserProvaider>(context)
                          //       .putData(S);
                          // });

                          //For store data of form
                          if (_formKey.currentState!.validate()) {
                            print('Entered  <==========>');

                            var userProvaider = context.read<UserProvaider>();
                            userProvaider.putData(User_Name!, phone, imgpath!);

                            //For OTP send
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '${countryController.text + phone}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {
                                print('${credential}  <==========>');
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print(
                                    '${e.toString()}  <==========>error===========>');
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Number_Auth.verify = verificationId;
                                print(Number_Auth.verify +
                                    "========================");
                                Navigator.pushNamed(context, 'verify');
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          }
                        },
                        child: Text("Send the code")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
