import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'EditCategory.dart';

class SelectByItem extends StatefulWidget {
  const SelectByItem({Key? key}) : super(key: key);

  @override
  State<SelectByItem> createState() => _SelectByItemState();
}

class _SelectByItemState extends State<SelectByItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Fetch data from Firestore
      future: fetchCategoriesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Text('No data available'); // Handle the case of no data
        } else {
          final categories = snapshot.data as List<Category>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Select By Category',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditCategory(),
                        ),
                      );
                      // Implement your edit logic here
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: InkWell(
                        onTap: () {
                          // Handle category selection
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: ClipOval(
                                child: Image.network(
                                  category.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(category.name) // Display category name
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<Category>> fetchCategoriesFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Select By Category')
          .get();

      final List<Category> categories = [];

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        final name = data['image_name'] as String;

        categories.add(Category(imageUrl: imageUrl, name: name));
      });

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}

class Category {
  final String imageUrl;
  final String name;

  Category({required this.imageUrl, required this.name});
}
