import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/basic_model.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: context.read<BasicModel>().page[context.watch<BasicModel>().i],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.watch<BasicModel>().i,
            onTap: (i){
              context.read<BasicModel>().changeIndex(i);
            },
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.room,),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.mode_edit),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.pets),label: ''),
            ],
          ),
        )
    );
  }
}
