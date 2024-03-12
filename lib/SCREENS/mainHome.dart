import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefluttre/ADMIN/loginAdmin.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';
import 'package:simplefluttre/SCREENS/blutoothCon.dart';
import 'package:simplefluttre/SCREENS/itemAdd.dart';
import 'package:simplefluttre/SCREENS/itemEdit.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

String date = "";
String cn = "";

class Menus {
  final String iconname;
  final String iconimg;
  Menus({required this.iconname, required this.iconimg});
}

class _MainHomeState extends State<MainHome> {
  List<Menus> l = [
    Menus(iconname: 'ITEM', iconimg: 'assets/add.png'),
    Menus(iconname: 'ITEM', iconimg: 'assets/edit.png'),
    Menus(iconname: 'STICKER', iconimg: 'assets/print.png'),
    Menus(iconname: 'STICKER', iconimg: 'assets/print.png'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    super.initState();
  }

  getcname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cn = prefs.getString("cname")!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("width = ${size.width}");
    print("height = ${size.height}");
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.of(context).pop(true);
          // Navigator.pushNamed(context, '/mainpage');
        }
      },
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.indigo,
        // appBar: AppBar(
        //   backgroundColor: Colors.yellow,
        //   elevation: 0,
        // ),
        // bottomNavigationBar: SizedBox(height: 40,width: 20,
        //   child: Align(alignment: Alignment.centerRight,
        //     child: FloatingActionButton(
        //         shape: CircleBorder(side: BorderSide(width: 2)), onPressed: () {}),
        //   ),
        // ),
        body: SafeArea(
            child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: l.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Container(
                        height: 160,
                        width: size.width / 1.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.red, Colors.orange],
                            stops: [0.112, 0.789],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    l[index].iconimg.toString(),
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                child: Text(
                                  "${l[index].iconname.toString()}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ItemADD()),
                          );
                        } else if (index == 1) {
                          Provider.of<PrintMethod>(context, listen: false)
                              .getItemList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ItemEdit()),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BluetoothConnection()),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              }),
        )),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => AdminLoginPage()),
        //     );
        //   },
        //   shape: CircleBorder(side: BorderSide(width: 0.5)),
        //   child: Text(
        //     "ADMIN\nLOGIN",
        //     style: TextStyle(fontSize: 10),
        //   ),
        // ),
      )),
    );
  }
}
