import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SliderProvaider extends ChangeNotifier {
  List<String> selectedImages = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  Future<void> fetchImageFromFirestore() async {
    // Fetch images from Firestore "slider" collection
    _subscription = FirebaseFirestore.instance
        .collection('slider')
        .snapshots()
        .listen((querySnapshot) {
      final List<String> imageUrls = [];

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        imageUrls.add(imageUrl);
      });

      selectedImages = imageUrls;
      notifyListeners(); // Notify listeners when data changes
    });
  }

  List<String> get getImageList {
    return selectedImages;
  }

  @override
  void dispose() {
    // Cancel the stream subscription in the dispose method
    _subscription?.cancel();
    super.dispose();
  }
}
