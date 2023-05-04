import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';

void main()async {

WidgetsFlutterBinding.ensureInitialized();

if(Platform.isWindows)
await DesktopWindow.setMinWindowSize(Size(650, 650));



  runApp( MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:HomeLayout(),
    );
  }
}


