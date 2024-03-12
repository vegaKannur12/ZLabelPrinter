import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simplefluttre/ADMIN/homeAdmin.dart';
import 'package:simplefluttre/COMPONENTS/custom_snackbar.dart';
import 'package:simplefluttre/COMPONENTS/textfldCommon.dart';


class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool pageload = false;
  @override
  void initState() {
    // TODO: implement initState
    pageload = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageload = false;
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.yellow,
        //   elevation: 0,
        // ),
        body: pageload
            ? SpinKitCircle(
                color: Colors.black,
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: size.height * 0.14,
                          ),
                          Container(
                              child: Image.asset(
                            "assets/lock.png",
                            fit: BoxFit.contain,
                            width: 300,
                            height: 300,
                          )),
                          SizedBox(
                            height: size.height * 0.054,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    "Login As Admin",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Widget_TextField(
                                typeoffld: TextInputType.none,
                                controller: username,
                                obscureNotifier: ValueNotifier<bool>(
                                    false), // For non-password field, you can set any initial value
                                hintText: 'Username',
                                prefixIcon: Icons.person,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please Enter Username';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Widget_TextField(
                                typeoffld: TextInputType.none,
                                controller: password,
                                obscureNotifier: ValueNotifier<bool>(
                                    true), // For password field, you can set any initial value
                                hintText: 'Password',
                                prefixIcon: Icons.lock,
                                isPassword: true,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: ()  {
                                      if (username.text.toLowerCase() ==
                                              "vega" &&
                                          password.text.toLowerCase() ==
                                              "321") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdminHomePage()),
                                        );
                                      } 
                                      else 
                                      {
                                        CustomSnackbar snackbar =
                                            CustomSnackbar();
                                        snackbar.showSnackbar(
                                            context,
                                            "Incorrect Username or Password",
                                            "");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 12),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
