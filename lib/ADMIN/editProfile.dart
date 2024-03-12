import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String p_string = "";
  TextEditingController editctrl = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    getProfileString();
    setState(() {
      isEdit = false;
    });
    super.initState();
  }

  getProfileString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    p_string = prefs.getString("prof_string")!;
    editctrl.text = p_string.toString();
    print("prooooooooooooooo=====${p_string.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isEdit = true;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.red,
                      ))
                ],
              ),
              isEdit
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: TextFormField(
                        controller: editctrl,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Code',
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Text(p_string.toString()),
                      ),
                    ),
              isEdit
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<PrintMethod>(context, listen: false)
                                .setProfileONEDit(editctrl.text.toString());
                            getProfileString();
                            setState(() {
                              isEdit = false;
                            });
                            print("updated");
                          },
                          child: Text("UPDATE"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEdit = false;
                            });
                          },
                          child: Text("CANCEL"),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
