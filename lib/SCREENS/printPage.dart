import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:simplefluttre/COMPONENTS/custom_snackbar.dart';
import 'package:simplefluttre/COMPONENTS/textfldCommon.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({
    super.key,
  });

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController qty_ctrl = TextEditingController();

  String selectedName = "";
  String selectedCode = "";
  String selectedRate = "";
  String selectedUnit = "";
  String selectedPack = "";
  String selectedExp = "";
  TextEditingController dateInput = TextEditingController();
  TextEditingController expdateInput = TextEditingController();
  String formattedDate = "";
  Map<String, dynamic>? selectedItem;
  int? selectedItemId;
  String pro="";
  String pro_name="";
  @override
  void initState() {
    String datetoday = DateFormat('dd-MM-yyyy').format(DateTime.now());
    dateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

    Provider.of<PrintMethod>(context, listen: false).getItemList();
    getProfile();
    super.initState();
  }
getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pro = prefs.getString("prof_string")!;
   pro_name = prefs.getString("label_name")!;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      appBar: AppBar(title: Consumer<PrintMethod>(
        builder: (BuildContext context, PrintMethod value, Widget? child) { return Text(pro_name.toString());}),
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
                        padding: EdgeInsets.only(right: 5, left: 5),
                        width: size.width / 1.11,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: size.width / 1.17,
                                  child: Container(
                                    width: 255,
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: DropdownButton<int>(
                                      isExpanded: true,
                                      hint: Text('Select item'),
                                      value: selectedItemId,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          selectedItemId = newValue;
                                          print("selectedID: $selectedItemId");
                                          final selectedItemMap =
                                              value.itemList.firstWhere(
                                            (item) => item['id'] == newValue,
                                            orElse: () => {},
                                          );
                                          if (selectedItemMap != null) {
                                            print(
                                                "selectedItemMap: $selectedItemMap");

                                            selectedName =
                                                selectedItemMap['name']
                                                    .toString();
                                            selectedCode =
                                                selectedItemMap['code']
                                                    .toString();
                                            selectedRate =
                                                selectedItemMap['rate']
                                                    .toString();
                                            selectedUnit =
                                                selectedItemMap['unit']
                                                    .toString();
                                            selectedPack =
                                                selectedItemMap['packing']
                                                    .toString();
                                            selectedExp =
                                                selectedItemMap['exp_days']
                                                    .toString();
                                            print(
                                                "selectedName: $selectedName");
                                            print(
                                                "selectedCode: $selectedCode");
                                            print(
                                                "selectedRate: $selectedRate");
                                            print(
                                                "selectedUnit: $selectedUnit");
                                            print(
                                                "selectedPackng: $selectedPack");
                                            print(
                                                "selectedExpiry: $selectedExp");
                                          }
                                          DateTime dateExp = DateTime.now().add(
                                              Duration(
                                                  days: int.parse(
                                                      selectedExp.toString())));
                                          expdateInput.text =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(dateExp);
                                          // Handle the selection here
                                        });
                                      },
                                      items: value.itemList
                                          .map<DropdownMenuItem<int>>((item) {
                                        return DropdownMenuItem<int>(
                                          value: item['id'],
                                          child: Text(item['name'].toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            selectedName!.isEmpty
                                ? Container()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Text("CODE",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 35,
                                            child: Text(selectedCode,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Text(
                                              "PACKING",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 35,
                                            child: Text(selectedPack,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Text("UNIT",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 35,
                                            child: Text(selectedUnit,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Text("MRP",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 35,
                                            child: Text("$selectedRate \u20B9",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Text("MFG",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 200,
                                            child: TextField(
                                              controller: dateInput,
                                              //editing controller of this TextField
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                // contentPadding:
                                                //     EdgeInsets.only(top: 5, bottom: 5),
                                                icon: Icon(Icons
                                                    .calendar_today), //icon of text field
                                                //label text of field
                                              ),
                                              readOnly: true,
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1950),
                                                        //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime(2100));

                                                if (pickedDate != null) {
                                                  print(pickedDate);
                                                  formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(pickedDate);
                                                  print(formattedDate);
                                                  DateTime newDate =
                                                      pickedDate.add(Duration(
                                                          days: int.parse(
                                                              selectedExp
                                                                  .toString()))); //formatted date output using intl package =>  2021-03-16
                                                  setState(() {
                                                    dateInput.text =
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(pickedDate);
                                                    expdateInput.text =
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(newDate);
                                                    print(
                                                        "newDate----$newDate");
                                                  });
                                                } else {}
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Text("Use Before",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 200,
                                            child: TextField(
                                              controller: expdateInput,
                                              //editing controller of this TextField
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                icon:
                                                    Icon(Icons.calendar_today),
                                                // contentPadding:
                                                //     EdgeInsets.only(top: 5, bottom: 5),
                                                // icon: Icon(Icons
                                                //     .calendar_today), //icon of text field
                                                //label text of field
                                              ),
                                              readOnly: true,
                                              //set it true, so that user will not able to edit text
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 35,
                                              width: 100,
                                              child: Text("Quantity",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            SizedBox(
                                                height: 40,
                                                width: 80,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  controller: qty_ctrl,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (text) {
                                                    if (text == null ||
                                                        text.isEmpty) {
                                                      return 'Please Enter quantity';
                                                    }
                                                    return null;
                                                  },
                                                )
                                                //  Widget_TextField(
                                                //   isSuffix: true,
                                                //   controller: qty_ctrl,
                                                //   obscureNotifier: ValueNotifier<bool>(
                                                //       false), // For non-password field, you can set any initial value
                                                //   hintText: 'QTY',
                                                //   prefixIcon: Icons.numbers,
                                                //   typeoffld: TextInputType.number,
                                                //   validator: (text) {
                                                //     if (text == null || text.isEmpty) {
                                                //       return 'Please Enter quantity';
                                                //     }
                                                //     return null;
                                                //   },
                                                // ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // TextButton(
                    //     onPressed: () {
                    //       print(
                    //           "yyyyyyyyyyyyyyyyyyyyyyyyyy${barcode_ctrl.text}\u0023${qty_ctrl.text}");
                    //     },
                    //     child: Text("viewdata")),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        child: Text(
                          "PRINT",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                            if (selectedName.isEmpty) {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(context, "Select item", "");
                            } else if (qty_ctrl.text.isEmpty) {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(
                                  context, "Enter Quantity", "");
                            } else {
                              value.printLabel(
                                  selectedCode,
                                  selectedName,
                                  selectedPack,
                                  selectedRate,
                                  qty_ctrl.text.toString(),
                                  selectedUnit,
                                  dateInput.text.toString(),
                                  expdateInput.text.toString());
                            }

                            // barcode_ctrl.clear();
                            // qty_ctrl.clear();
                            // sale_ctrl.clear();
                            // "${barcode_ctrl.text}\u0023${qty_ctrl.text}");
                        
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
