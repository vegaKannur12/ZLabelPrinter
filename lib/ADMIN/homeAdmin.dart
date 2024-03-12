import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:simplefluttre/ADMIN/editProfile.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<PrintMethod>(context, listen: false)
        .getprintProfile(context, "0", 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PrintMethod>(
        builder: (BuildContext context, PrintMethod value, Widget? child) {
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
                        "Download Label Config here..!",
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
                ListView.builder(
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
                                      Provider.of<PrintMethod>(context,
                                              listen: false)
                                          .getprintProfile(
                                              context,
                                              value.label_list[index]
                                                  ['print_id'],
                                              index);
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
                                          builder: (context) => EditProfile(),
                                        ),
                                      );
                                    },
                                    icon:
                                    Icon(
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
