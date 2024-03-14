import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefluttre/COMPONENTS/custom_snackbar.dart';
import 'package:simplefluttre/COMPONENTS/textfldCommon.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';

class OtherEdit extends StatefulWidget {
  String cus_carNo;
  String fssiNo;
  OtherEdit({super.key, required this.cus_carNo, required this.fssiNo});

  @override
  State<OtherEdit> createState() => _OtherEditState();
}

class _OtherEditState extends State<OtherEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cuscare_ctrl = TextEditingController();
  TextEditingController fssai_ctrl = TextEditingController();
  bool dataError = false;

  bool is_editt = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Edit Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  is_editt = true;
                });
              },
              icon: Icon(Icons.edit,color: Colors.green,))
        ],
      ),
      content: SingleChildScrollView(
          child: is_editt
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: cuscare_ctrl,
                      decoration: InputDecoration(
                        labelText: 'Customer Care',
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Customer Care Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: fssai_ctrl,
                      decoration: InputDecoration(
                        labelText: 'fssai Number',
                        prefixIcon: Icon(Icons.food_bank_rounded),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter fssai Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {

                          if (cuscare_ctrl.text.isEmpty ||
                              fssai_ctrl.text.isEmpty) {
                            setState(() {
                              dataError = true;
                            });
                          } else {
                            Provider.of<PrintController>(context, listen: false)
                                .setOtherDetails(cuscare_ctrl.text.toString(),
                                    fssai_ctrl.text.toString());
                            cuscare_ctrl.clear();
                            fssai_ctrl.clear();
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Details Added",
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
                                        Navigator.of(context).pop();
                                        Navigator.pushNamed(
                                            context, '/adminhome');
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
                    if (dataError)
                      Text(
                        'Fill all fields...',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(height: 33,width: 33,child: Image.asset("assets/cuc.png"),),
                        Text(" ${widget.cus_carNo.toString()}"),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(height: 33,width: 33,child: Image.asset("assets/fss.png"),),
                        Text(" ${widget.fssiNo.toString()}"),
                      ],
                    ),
                  ],
                )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
