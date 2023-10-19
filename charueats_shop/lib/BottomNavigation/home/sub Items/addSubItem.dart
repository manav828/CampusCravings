import 'package:charueats_shop/FromFirebase/SubItems/subItemProvaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSubItem extends StatefulWidget {
  // const AddSubItem({Key? key}) : super(key: key);
  AddSubItem(this.subItemId);
  String subItemId;
  @override
  State<AddSubItem> createState() => _AddSubItemState();
}

String subIteName = '';

class _AddSubItemState extends State<AddSubItem> {
  bool isLoading = false;
  TextEditingController _foodNameController = TextEditingController();
  TextEditingController _foodPriceController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwaminarayanFoodSelected = false;
  bool isJainFoodSelected = false;
  bool isRegularFoodSelected = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Food Item Information'),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _foodNameController,
              decoration: InputDecoration(
                labelText: 'Food Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the food name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _foodPriceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the price';
                }
                return null;
              },
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Row(
            //       children: [
            //         Checkbox(
            //           value: isSwaminarayanFoodSelected,
            //           onChanged: (value) {
            //             setState(() {
            //               isSwaminarayanFoodSelected = value ?? false;
            //             });
            //           },
            //         ),
            //         Text('Swaminarayan Food'),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Checkbox(
            //           value: isJainFoodSelected,
            //           onChanged: (value) {
            //             setState(() {
            //               isJainFoodSelected = value ?? false;
            //             });
            //           },
            //         ),
            //         Text('Jain Food'),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Checkbox(
            //           value: isRegularFoodSelected,
            //           onChanged: (value) {
            //             setState(() {
            //               isRegularFoodSelected = value ?? false;
            //             });
            //           },
            //         ),
            //         Text('Regular'),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            setState(() {
              isLoading = true; // Start the loading animation
            });

            if (_formKey.currentState!.validate()) {
              String foodName = _foodNameController.text;
              String foodP = (_foodPriceController.text);
              double foodPrice = double.parse(foodP);

              String message = 'Food Name: $foodName\nPrice: $foodPrice';

              bool isSend = await SubItemProvaider()
                  .sendSubItem(foodName, widget.subItemId, foodPrice);
              if (isSend) {
                Navigator.of(context).pop(); // Close the dialog
                Provider.of<SubItemProvaider>(context, listen: false)
                    .fatchSubItem(widget.subItemId);
              }
              // Print the information or perform any other action
              print(message);

              setState(() {
                isLoading = false; // Start the loading animation
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // alignment: Alignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancle",
                    style: TextStyle(color: Colors.black),
                  )),
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
                child: CircularProgressIndicator(), // Loading animation
              ),
            ],
          ),
        ),
      ],
    );
  }
}
