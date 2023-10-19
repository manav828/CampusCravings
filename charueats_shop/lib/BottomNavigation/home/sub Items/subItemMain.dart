import 'package:charueats_shop/BottomNavigation/home/sub%20Items/subSingleItem.dart';
import 'package:charueats_shop/FromFirebase/SubItems/subItemProvaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addSubItem.dart';

class SubItemMain extends StatefulWidget {
  // const SubItemMain({Key? key}) : super(key: key);
  SubItemMain(this.mainItemId, this.ItemName);
  String? mainItemId;
  String? ItemName;

  @override
  State<SubItemMain> createState() => _SubItemMainState();
}

class _SubItemMainState extends State<SubItemMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      SubItemProvaider subItemProvaider =
          Provider.of<SubItemProvaider>(context, listen: false);
      subItemProvaider.fatchSubItem(widget.mainItemId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.ItemName!),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddSubItem(widget.mainItemId!)));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<SubItemProvaider>(
          builder: (context, subItemProvaider, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return SubSingleItem(
              mainItemId: widget.mainItemId!,
              subItemId: subItemProvaider.getSubItemsList[index].subItemId,
              subItemName: subItemProvaider.getSubItemsList[index].subItemName,
              subItemPrice:
                  subItemProvaider.getSubItemsList[index].subItemPrice,
              onDelete: () {
                subItemProvaider.deleteSubItem(widget.mainItemId!,
                    subItemProvaider.getSubItemsList[index].subItemId);
              },
            );
          },
          itemCount: subItemProvaider.getSubItemsList.length,
        );
      }),
    );
  }
}
