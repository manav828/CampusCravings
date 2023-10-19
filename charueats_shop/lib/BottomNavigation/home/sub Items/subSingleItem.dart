import 'package:flutter/material.dart';

import '../../../FromFirebase/SubItems/subItemProvaider.dart';

class SubSingleItem extends StatefulWidget {
  SubSingleItem({
    this.subItemPrice = 0,
    this.subItemName = '',
    this.onDelete,
    this.subItemId = '',
    this.mainItemId = '',
  });

  String subItemName;
  double subItemPrice;
  String subItemId;
  String mainItemId;
  Function? onDelete;

  @override
  State<SubSingleItem> createState() => _SubSingleItemState();
}

class _SubSingleItemState extends State<SubSingleItem> {
  bool isSwaminarayanFoodSelected = true;
  bool isJainFoodSelected = true;
  bool isRegularFoodSelected = false;

  @override
  Widget build(BuildContext context) {
    String availabilityLabel = getAvailabilityLabel();

    return Container(
      margin: EdgeInsets.all(15),
      height: 90,
      width: MediaQuery.of(context).size.width * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.subItemName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Price: ${widget.subItemPrice}₹'),
                IconButton(
                  onPressed: () {
                    widget.onDelete?.call();
                    SubItemProvaider()
                        .deleteSubItem(widget.mainItemId, widget.subItemId!);
                    SubItemProvaider().fatchSubItem(widget.mainItemId);
                  },
                  icon: Icon(Icons.delete_outline),
                )
              ],
            ),
            // Text(
            //     'Availability: $availabilityLabel'), // Display availability label here
          ],
        ),
      ),
    );
  }

  String getAvailabilityLabel() {
    List<String> availableOptions = [];

    if (isSwaminarayanFoodSelected) {
      availableOptions.add('Swaminarayan');
    }
    if (isJainFoodSelected) {
      availableOptions.add('Jain');
    }
    if (isRegularFoodSelected) {
      availableOptions.add('Regular');
    }

    if (availableOptions.isEmpty) {
      return 'Not specified';
    } else if (availableOptions.length == 3) {
      return 'All';
    } else {
      return availableOptions.join(', ');
    }
  }
}
