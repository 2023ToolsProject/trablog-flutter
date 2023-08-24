import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/main_page.dart';
import 'package:trablog/page/memory_page/memory_first.dart';
import 'package:trablog/page/sign_page/title_page.dart';
import 'package:trablog/view_model/memory_model.dart';
import 'package:trablog/view_model/title_model.dart';
import 'package:trablog/singleton/storage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TitleModel>().toNextPage(() async{
      if((await Storage.pref!.getString('accessToken')) == '1234'){
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context)=>MemoryModel(),
                child: const MemoryFirst(),
            ))
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const TitlePage())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/cat/cat.png'))),
        )),
      ),
    );
  }
}
