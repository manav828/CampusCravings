import 'package:charueats_shop/BottomNavigation/home/sub%20Items/subItemMain.dart';
import 'package:flutter/material.dart';

import '../../FromFirebase/MainItems/mainItemProvaider.dart';

class HomeSingleItem extends StatefulWidget {
  HomeSingleItem(
      {this.imageUrl, this.MainItemName, this.itemId, this.onDelete});
  String? MainItemName;
  String? imageUrl;
  String? itemId;
  Function? onDelete;
  @override
  State<HomeSingleItem> createState() => _HomeSingleItemState();
}

class _HomeSingleItemState extends State<HomeSingleItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SubItemMain(
                  widget.itemId,
                  widget.MainItemName,
                )));
        // print(widget.MainItemName);
      },
      child: Container(
        height: 100,

        decoration: BoxDecoration(
          // color: Colors.yellow.shade200,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(8),
        // height: 110,
        // width: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),

                    // color: Colors.yellow.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Opacity(
                    opacity: 1,
                    child: Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.fill,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow.shade200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(widget.MainItemName!),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Conform Delete Main Item"),
                                content:
                                    Text('Are you sure you want to delete it '),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancle'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.onDelete?.call();
                                        MainItemProvaider()
                                            .deleteMainItem(widget.itemId!);
                                        MainItemProvaider().fatchMainItems();
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            });

                        print('${widget.MainItemName} deleted');
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
