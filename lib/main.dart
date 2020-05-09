import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'ui/input_date_view.dart';
import 'ui/list_data_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        "/main": (context) => new MyApp(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: InputDateView(),
          ),
        ),
      ),
    );
  }
}
