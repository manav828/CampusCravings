import 'dart:io';

import 'package:charueats_shop/provaider/ForUser/user_provaider.dart';
import 'package:charueats_shop/shop_onbording/phone.dart';
import 'package:charueats_shop/shop_onbording/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  String? token;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }

  Future<String> getDeviceToken() async {
    token = await messaging.getToken();
    return token!;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  String imageUrl = '';

  //for access shop name any where
  void saveShopNameToSharedPreferences(String shopName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('shopName', shopName);
  }

  Future<bool> _uploadImage() async {
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('Shops')
          .child(context.read<UserProvaider>().getShopName!)
          .child('/' + context.read<UserProvaider>().getShopName!);
      uploadTask =
          ref.putFile(File(context.read<UserProvaider>().getImage.toString()));
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('Image URL => ' + imageUrl);

      var userProvaider = await context.read<UserProvaider>();
      userProvaider.imageUrl(imageUrl);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void sendUserData() async {
    // String ShopName = context.read<UserProvaider>().getShopName!;
    // String? OwnerName = context.read<UserProvaider>().getOwnerName;
    // String? PhoneNumber = context.read<UserProvaider>().getPhone;
    // String? ImageUrl = context.read<UserProvaider>().getImageUrl;

    final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;
    try {
      await FirebaseFirestore.instance
          .collection('ShopData')
          .doc(firebaseUser)
          .set({
        'ShopName': context.read<UserProvaider>().getShopName,
        'OwnerName': context.read<UserProvaider>().getOwnerName,
        'PhoneNumber': context.read<UserProvaider>().getPhone,
        'ImageUrl': context.read<UserProvaider>().getImageUrl,
        'token': token,
        'AdminPermission': false,
      });

      print('data uploded ==========================fefbjhfhekf');
    } catch (e) {
      print(e.toString());
    }

    //       .collection('UserData')
    //       .doc(firebaseUser)
    //       .collection('cart')
    //       .doc('${itemId}')
    //       .update({
    //     "itemCount": itemCount,
    //     "totalPrice": widget.finalTotal,
    //   });
  }

  @override
  Widget build(BuildContext context) {
    print('verify');

    print(context.read<UserProvaider>().getShopName);
    print(context.read<UserProvaider>().getOwnerName);
    print(context.read<UserProvaider>().getPhone);
    print(context.read<UserProvaider>().getImage.toString());

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    // final String verificationId =
    //     ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (value) {
                  code = value;
                  print(code);
                },
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
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFD6C37F),
                        Color(0xFFB38F4C),
                        Color(0xFFD6C37F),
                        Color(0xFFD6C37F),
                        Color(0xFFB38F4C),
                        Color(0xFFD6C37F),
                      ],
                      stops: [1.0, 0.1, 1.0, 1.0, 1.0, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        if (MyPhone.verify.isNotEmpty && code.isNotEmpty) {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: MyPhone.verify,
                            smsCode: code,
                          );

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          await SharedPreferencesHelper.setLoggedIn(
                              true); /////////////
                          bool isTrue = await _uploadImage();

                          //send data to firebase
                          sendUserData();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'bottomNav',
                            (route) => false,
                          );
                        } else {
                          print("Verification ID or SMS code is empty.");
                        }
                      } catch (e) {
                        print(e.toString() + ' <====error');
                      }
                    },
                    child: Text("Verify Phone Number"),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'phone',
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black),
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
