import 'package:crud_list/Home/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/View/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HomeProvider(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
      },
    ),
  ));
}
