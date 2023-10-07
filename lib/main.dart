import 'package:flutter/material.dart';
import 'package:trablog/page/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/title_model.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> TitleModel(),
      child: const SplashScreen(),
    );
  }
}


