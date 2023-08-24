import 'package:flutter/material.dart';
import 'package:trablog/page/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/title_model.dart';
import 'package:trablog/singleton/storage.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Storage.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> TitleModel(),
        child: const SplashScreen(),
    );
  }
}


