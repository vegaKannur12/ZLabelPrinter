import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:simplefluttre/COMPONENTS/custom_snackbar.dart';
import 'package:simplefluttre/COMPONENTS/textfldCommon.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';
import 'package:simplefluttre/LOCALDB/localDb.dart';

class ItemADD extends StatefulWidget {
  const ItemADD({
    super.key,
  });

  @override
  State<ItemADD> createState() => _ItemADDState();
}

class _ItemADDState extends State<ItemADD> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController code_ctrl = TextEditingController();
  TextEditingController rate_ctrl = TextEditingController();
  TextEditingController unit_ctrl = TextEditingController();
  TextEditingController pkg_ctrl = TextEditingController();
  TextEditingController day_ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,title: Center(child: Text("ADD ITEM",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
          // actions: [
          //   IconButton(onPressed: () {}, icon: Icon(Icons.document_scanner_sharp))
          // ],
          ),
      body: Consumer<PrintMethod>(
        builder: (BuildContext context, PrintMethod value, Widget? child) {
          return Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 5, right: 5),

                        // height: 280,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.15,
                                  child: Widget_TextField(
                                    isSuffix: true,
                                    controller: name_ctrl,
                                    obscureNotifier: ValueNotifier<bool>(
                                        false), // For non-password field, you can set any initial value
                                    hintText: 'Name',
                                    prefixIcon: Icons.barcode_reader,
                                    typeoffld: TextInputType.text,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please Enter Name';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.15,
                                  child: Widget_TextField(
                                    isSuffix: true,
                                    controller: code_ctrl,
                                    obscureNotifier: ValueNotifier<bool>(
                                        false), // For non-password field, you can set any initial value
                                    hintText: 'Item Code',
                                    prefixIcon: Icons.barcode_reader,
                                    typeoffld: TextInputType.number,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please Enter code';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.15,
                                  child: Widget_TextField(
                                    isSuffix: true,
                                    controller: rate_ctrl,
                                    obscureNotifier: ValueNotifier<bool>(
                                        false), // For non-password field, you can set any initial value
                                    hintText: 'Rate',
                                    prefixIcon: Icons.numbers,
                                    typeoffld: TextInputType.number,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please Enter Rate';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.15,
                                  child: Widget_TextField(
                                    isSuffix: true,
                                    controller: unit_ctrl,
                                    obscureNotifier: ValueNotifier<bool>(
                                        false), // For non-password field, you can set any initial value
                                    hintText: 'Unit',
                                    prefixIcon: Icons.person,

                                    typeoffld: TextInputType.number,

                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please Enter Unit';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.15,
                                  child: Widget_TextField(
                                    isSuffix: true,
                                    controller: pkg_ctrl,
                                    obscureNotifier: ValueNotifier<bool>(
                                        false), // For non-password field, you can set any initial value
                                    hintText: 'Packing',
                                    prefixIcon: Icons.padding,

                                    typeoffld: TextInputType.number,

                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please Enter Packing';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.15,
                                  child: Widget_TextField(
                                    isSuffix: true,
                                    controller: day_ctrl,
                                    obscureNotifier: ValueNotifier<bool>(
                                        false), // For non-password field, you can set any initial value
                                    hintText: 'Expiry Days',
                                    prefixIcon: Icons.barcode_reader,
                                    typeoffld: TextInputType.number,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please Enter Expiry Days';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        child: Text(
                          "ADD",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                            if (name_ctrl.text.isEmpty) {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(context, "Enter Name", "");
                              
                            }
                            else if(code_ctrl.text.isEmpty)
                            {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(context, "Enter Code", "");

                            }
                            else if(rate_ctrl.text.isEmpty)
                            {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(context, "Enter Rate", "");

                            }
                            else if(day_ctrl.text.isEmpty)
                            {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(context, "Enter Expiry Days", "");

                            }
                            else
                            {
                            await BarcodeDB.instance.insertItemDetails(
                                name_ctrl.text.toString(),
                                code_ctrl.text.toString(),
                                rate_ctrl.text.toString(),
                                unit_ctrl.text.toString(),
                                pkg_ctrl.text.toString(),
                                int.parse(day_ctrl.text));
                            Provider.of<PrintMethod>(context, listen: false)
                                .getItemList();
                                name_ctrl.clear();
                                code_ctrl.clear();
                                rate_ctrl.clear();
                                unit_ctrl.clear();
                                pkg_ctrl.clear();
                                day_ctrl.clear();
                                showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Item Added",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: const Text('Ok'),
                                        onPressed: () async {
                                          // Provider.of<Controller>(context,
                                          //         listen: false)
                                          //     .clearCardID("0");
                                          // Provider.of<Controller>(context,
                                          //         listen: false)
                                          //     .setcusnameAndPhone("", "", context);
                                          Navigator.pop(context);
                                          // Navigator.pushNamed(context, '/mainpage');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                          }
                        },
                      ),
                    ),

                    // TextButton(
                    //     onPressed: () {
                    //       Provider.of<Controller>(context, listen: false)
                    //           .getprintProfile(context);
                    //     },
                    //     child: Text("Dataaaa"))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
