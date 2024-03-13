import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplefluttre/COMPONENTS/custom_snackbar.dart';
import 'package:simplefluttre/COMPONENTS/textfldCommon.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';

class OtherEdit extends StatefulWidget {
  const OtherEdit({super.key});

  @override
  State<OtherEdit> createState() => _OtherEditState();
}

class _OtherEditState extends State<OtherEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cuscare_ctrl = TextEditingController();
  TextEditingController fssai_ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(
              child: Text(
            "ADD OTHER DETAILS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        body: Consumer<PrintController>(
            builder: (BuildContext context, PrintController value, Widget? child) {
          return Center(
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: size.width / 1.15,
                          child: Widget_TextField(
                            isSuffix: true,
                            controller: cuscare_ctrl,
                            obscureNotifier: ValueNotifier<bool>(
                                false), // For non-password field, you can set any initial value
                            hintText: 'Customer Care Number',
                            prefixIcon: Icons.phone_android,
                            typeoffld: TextInputType.number,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please Enter Customer Care Number';
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
                            controller: fssai_ctrl,
                            obscureNotifier: ValueNotifier<bool>(
                                false), // For non-password field, you can set any initial value
                            hintText: 'fssai Number',
                            prefixIcon: Icons.food_bank_rounded,
                            typeoffld: TextInputType.number,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please Enter fssai Number';
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
                          if (cuscare_ctrl.text.isEmpty) {
                            CustomSnackbar snackbar = CustomSnackbar();
                            snackbar.showSnackbar(
                                context, "Enter Customercare no.", "");
                          } else if (fssai_ctrl.text.isEmpty) {
                            CustomSnackbar snackbar = CustomSnackbar();
                            snackbar.showSnackbar(
                                context, "Enter fssai no.", "");
                          } else {
                            Provider.of<PrintController>(context, listen: false)
                                .setOtherDetails(cuscare_ctrl.text.toString(),
                                    fssai_ctrl.text.toString());
                            cuscare_ctrl.clear();
                            fssai_ctrl.clear();
                            showDialog(
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
                                        Navigator.pop(context);
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
                  ]))));
        }));
  }
}
