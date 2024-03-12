import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefluttre/ADMIN/loginAdmin.dart';
import 'package:simplefluttre/ADMIN/loginAdminDialog.dart';
import 'package:simplefluttre/LOCALDB/localDb.dart';
import 'package:simplefluttre/LOCALDB/tablelist.dart';
import 'package:simplefluttre/COMPONENTS/custom_snackbar.dart';
import 'package:simplefluttre/SCREENS/itemAdd.dart';
import 'package:simplefluttre/ADMIN/homeAdmin.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';
import 'package:simplefluttre/SCREENS/printPage.dart';

class BluetoothConnection extends StatefulWidget {
  const BluetoothConnection({Key? key}) : super(key: key);

  @override
  State<BluetoothConnection> createState() => _BluetoothConnectionState();
}

class _BluetoothConnectionState extends State<BluetoothConnection> {
  String pro = "";
  String pro_name = "";
  // PrintMethod pm=PrintMethod();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PrintMethod>(context, listen: false).discovery();
      // subscription to listen change status of bluetooth connection
      Provider.of<PrintMethod>(context, listen: false).subStatus();
      Provider.of<PrintMethod>(context, listen: false).scan();
      getProfile();
    });
    super.initState();
  }

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pro = prefs.getString("prof_string")!;
    pro_name = prefs.getString("label_name")!; print("proofil = $pro");
    print("proofilNM = $pro_name");
  }

  @override
  Widget build(BuildContext context) {
   
    bool isSelected = false;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          //  title: Center(child: Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: const Text('CONNECT PRINTER',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
          // )),
          title: Row(
            children: [
              IconButton(
                onPressed: () async {
                  List<Map<String, dynamic>> list =
                      await BarcodeDB.instance.getListOfTables();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TableList(list: list)),
                  );
                },
                icon: Icon(Icons.edit_document, color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemADD()),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.white))
            ],
          ),
          actions: [
            Consumer<PrintMethod>(
                builder: (BuildContext context, PrintMethod value,
                        Widget? child) =>
                    // value.profile_string == "" || value.profile_string == " "
                    //     ? Container(
                    //         height: 40,
                    //         // decoration: BoxDecoration(color: Colors.amber),
                    //         child: OutlinedButton(
                    //             style: OutlinedButton.styleFrom(
                    //                 shape: StadiumBorder(
                    //                     side: BorderSide(
                    //                         color: Colors.yellow, width: 2))),
                    //             onPressed: () {
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => LabelSelect()),
                    //               );
                    //               setState(() {});
                    //             },
                    //             child: Text(
                    //               'Select Label',
                    //               style: TextStyle(
                    //                   fontSize: 18, color: Colors.white),
                    //             )),
                    //       )
                    //     :
                    Row(
                      children: [
                        Text(
                          pro_name.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              // LoginDialog l=LoginDialog();
                              // l.dialogBuilder(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LoginDialog();
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.yellow,
                            ))
                      ],
                    )),
          ],
        ),
        body: Consumer<PrintMethod>(
          builder: (BuildContext context, PrintMethod value, Widget? child) {
            return Center(
              child: Container(
                height: double.infinity,
                constraints: const BoxConstraints(maxWidth: 400),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<PrintMethod>(context, listen: false)
                              .scan();
                        },
                        icon: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            child: Icon(Icons.refresh)),
                      ),
                      value.isScanning
                          ? const CircularProgressIndicator()
                          : Column(
                              children: value.devices
                                  .map(
                                    (device) => ListTile(
                                      title: Text(device.name),
                                      subtitle: Text(device.address),
                                      trailing: isSelected == true
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            )
                                          : SizedBox(),
                                      selectedColor: Colors.blue,
                                      onTap: () {
                                        // do something
                                        value.selectDevice(device);
                                        print('device====------------>$device');
                                        setState(() {
                                          isSelected = true;
                                        });
                                      },
                                    ),
                                  )
                                  .toList()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.yellow, // background color
                                  foregroundColor: Colors.black, // text color
                                  elevation:
                                      5, // button's elevation when it's pressed
                                ),
                                onPressed: value.selectedPrinter == null ||
                                        value.isConnected
                                    ? null
                                    : () async {
                                        await value.connectDevice();
                                        if (value.isConnected) {
                                          if (pro.toString().isEmpty ||
                                              pro.toString() == "" ||
                                              pro.toString() == null) {
                                            CustomSnackbar snackbar =
                                                CustomSnackbar();

                                            snackbar.showSnackbar(
                                                context, "Profile Missing", "");
                                          } else {
                                            SchedulerBinding.instance
                                                .addPostFrameCallback((_) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrintPage(),
                                                ),
                                              );
                                            });
                                          }
                                        } else {
                                          CustomSnackbar snackbar =
                                              CustomSnackbar();

                                          snackbar.showSnackbar(
                                              context, "Connection failed", "");
                                        }
                                      },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Connect",
                                        textAlign: TextAlign.center),
                                    value.connectLoading
                                        ? SizedBox(
                                            height: 25,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ))
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.yellow, // background color
                                  foregroundColor: Colors.black, // text color
                                  elevation:
                                      5, // button's elevation when it's pressed
                                ),
                                onPressed: value.selectedPrinter == null ||
                                        !value.isConnected
                                    ? null
                                    : () {
                                        if (value.selectedPrinter != null) {
                                          value.bluetoothManager.disconnect();
                                        }
                                        setState(() {
                                          value.isConnected = false;
                                        });
                                      },
                                child: const Text("Disconnect",
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
