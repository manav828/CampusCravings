import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUrlProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> imageUrls = [];

  StreamSubscription<QuerySnapshot>? _subscription;

  void fetchImagesFromFirestore() async {
    _subscription = FirebaseFirestore.instance
        .collection('slider')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<String> newList = [];
      print("ikfdewnlfkjehkfwejkfnewljfnwelkf");
      for (var e in snapshot.docs) {
        newList.add(e.get('image_url'));
        print(e.get('image_url'));
      }
      imageUrls = newList;
      notifyListeners();
    });
  }

  List<String> get getShopItemsList {
    return imageUrls;
  }
}
