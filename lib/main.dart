import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simple_bluetooth_printer/flutter_simple_bluetooth_printer.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:simplefluttre/SCREENS/blutoothCon.dart';
import 'package:simplefluttre/SCREENS/itemAdd.dart';
import 'package:simplefluttre/SCREENS/ADMIN/homeAdmin.dart';
import 'package:simplefluttre/CONTROLLER/printClass.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simplefluttre/SCREENS/mainHome.dart';
import 'package:simplefluttre/SCREENS/printPage.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PrintController()),
      // ChangeNotifierProvider(create: (_) => RegistrationController()),
    ],
    child: const MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       routes: {
        '/mainhome': (context) => MainHome(),
        '/bluetoothhome': (context) => BluetoothConnection(),
      },
      home: 
      // LabelSelect(),
      // ItemADD(),
      //  BluetoothConnection(),
      // ConnectSelection()
      // PrintPage(),
      MainHome(),
      // AdminHomePage(),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('en', 'GB'),
      ],
    );
  }
}

