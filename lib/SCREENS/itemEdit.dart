import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';
import 'package:simplefluttre/LOCALDB/localDb.dart';

class ItemEdit extends StatefulWidget {
  const ItemEdit({super.key});

  @override
  State<ItemEdit> createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController code_ctrl = TextEditingController();
  TextEditingController rate_ctrl = TextEditingController();
  TextEditingController unit_ctrl = TextEditingController();
  TextEditingController pkg_ctrl = TextEditingController();
  TextEditingController day_ctrl = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // filteredItemList=Provider.of<PrintMethod>(context, listen: false).itemList;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(
              child: Text(
            "EDIT ITEM",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
          // actions: [
          //   IconButton(onPressed: () {}, icon: Icon(Icons.document_scanner_sharp))
          // ],
        ),
        body: Consumer<PrintMethod>(
            builder: (BuildContext context, PrintMethod value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                
                TextFormField(
                  controller: searchController, // Add a TextEditingController
                  onChanged: (val) {
                    setState(() {
                      Provider.of<PrintMethod>(context, listen: false)
                          .searchItem(val);
                      // Update the filteredItemList based on the search query
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Search Item",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon:
                          IconButton(onPressed: () {
                            Provider.of<PrintMethod>(context, listen: false)
                          .searchItem("");
                          searchController.clear();
                          }, icon: Icon(Icons.close))),
                ),
                // value.filteredItemList.isEmpty?

                // :
                value.searchLoading?
                Expanded(child: SpinKitCircle(color: Colors.black54,))
                :
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: value.filteredItemList.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            child: Column(
                              children: [
                                ListTile(
                                  tileColor: Colors.black,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value.filteredItemList[index]['name']
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value.isEditingList[index]
                                          ? Container(
                                              color: Colors.white,
                                              height: 40,
                                              width: 100,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder()),
                                                controller: code_ctrl,
                                              ))
                                          : Text(
                                              value.filteredItemList[index]
                                                      ['code']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width / 2.6,
                                        color: Colors.yellow,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Rate "),
                                            value.isEditingList[index]
                                                ? Container(
                                                    color: Colors.white,
                                                    height: 40,
                                                    width: 80,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                      controller: rate_ctrl,
                                                    ))
                                                : Text(
                                                    "${double.parse(value.filteredItemList[index]['rate']).toStringAsFixed(2)} \u20B9 ",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width / 2.6,
                                        color: Colors.yellow,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Unit "),
                                            value.isEditingList[index]
                                                ? Container(
                                                    color: Colors.white,
                                                    height: 40,
                                                    width: 80,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                      controller: unit_ctrl,
                                                    ))
                                                : Text(
                                                    value.filteredItemList[
                                                            index]['unit']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width / 2.6,
                                        color: Colors.yellow,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Packing "),
                                            value.isEditingList[index]
                                                ? Container(
                                                    color: Colors.white,
                                                    height: 40,
                                                    width: 70,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                      controller: pkg_ctrl,
                                                    ))
                                                : Text(
                                                    "${value.filteredItemList[index]['packing'].toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width / 2.6,
                                        color: Colors.yellow,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Expiry "),
                                            value.isEditingList[index]
                                                ? Container(
                                                    color: Colors.white,
                                                    height: 40,
                                                    width: 80,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                      controller: day_ctrl,
                                                    ))
                                                : Text(
                                                    value.filteredItemList[
                                                            index]['exp_days']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (value.isEditingList[index]) ...[
                                      IconButton(
                                        onPressed: () {
                                          setState(() async {
                                            // Update the code in your data source
                                            // value.itemList[index]['code'] = tempCodeList[index];
                                            // Exit edit mode
                                            int idd = int.parse(value
                                                .filteredItemList[index]['id']
                                                .toString());
                                            await BarcodeDB.instance
                                                .updateItemDetails(
                                                    idd,
                                                    code_ctrl.text.toString(),
                                                    rate_ctrl.text.toString(),
                                                    unit_ctrl.text.toString(),
                                                    pkg_ctrl.text.toString(),
                                                    day_ctrl.text.toString());
                                            Provider.of<PrintMethod>(context,
                                                    listen: false)
                                                .getItemList();
                                            value.isEditingList[index] =
                                                false;
                                          });
                                        },
                                        icon: Icon(Icons.update,
                                            color: Colors.green),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            value.isEditingList[index] =
                                                false;
                                          });
                                        },
                                        icon: Icon(Icons.cancel),
                                      ),
                                    ] else
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              value.isEditingList[index] =
                                                  !value.isEditingList[index];
                                              code_ctrl.text = value
                                                  .filteredItemList[index]
                                                      ['code']
                                                  .toString();
                                              rate_ctrl.text = value
                                                  .filteredItemList[index]
                                                      ['rate']
                                                  .toString();
                                              unit_ctrl.text = value
                                                  .filteredItemList[index]
                                                      ['unit']
                                                  .toString();
                                              pkg_ctrl.text = value
                                                  .filteredItemList[index]
                                                      ['packing']
                                                  .toString();
                                              day_ctrl.text = value
                                                  .filteredItemList[index]
                                                      ['exp_days']
                                                  .toString();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.red,
                                          ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ]);
                      }),
                ),
              ],
            ),
          );
        }));
  }
}
