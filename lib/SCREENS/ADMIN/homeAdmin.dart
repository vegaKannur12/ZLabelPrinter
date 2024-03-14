import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefluttre/SCREENS/ADMIN/editProfile.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';
import 'package:simplefluttre/SCREENS/otherEdit.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String? cu = "";
  String? fs = "";
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<PrintController>(context, listen: false)
        .getprintProfile(context, "0", 0, "0");
    super.initState();
  }

  getCuscarANdfssai() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cu = prefs.getString("cus_care");
    fs = prefs.getString("fssai_no");
    print("befor edit==== cuscr->$cu\n fssai->$fs");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                getCuscarANdfssai();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtherEdit(
                            cus_carNo: cu.toString(),
                            fssiNo: fs.toString(),
                          )),
                );
              },
              child: Text(
                "Edit fssai/cusomerCare No.",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ))
        ],
      ),
      body: Consumer<PrintController>(
        builder: (BuildContext context, PrintController value, Widget? child) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Download & Edit Label Config here..",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                value.isprofileLoading
                    ? SpinKitThreeBounce(
                        color: Colors.green,
                        size: 30,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(2.0),
                        itemCount: value.label_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          int i = index;
                          return Card(
                            color: Colors.blue,
                            child: SizedBox(
                              height: 70,
                              child: ListTile(
                                // tileColor: Colors.amber,
                                onTap: () {},
                                title: Text(
                                  value.label_list[index]['name'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: SizedBox(
                                  width: 97,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Provider.of<PrintController>(
                                                    context,
                                                    listen: false)
                                                .getprintProfile(
                                                    context,
                                                    value.label_list[index]
                                                        ['print_id'],
                                                    index,
                                                    "0");
                                          },
                                          icon:
                                              // value.isprofileLoading && i==index?CircularProgressIndicator(color: Colors.white,) :
                                              Icon(
                                            Icons.download,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
