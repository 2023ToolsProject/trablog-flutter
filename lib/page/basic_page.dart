import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/basic_model.dart';
import 'package:trablog/view_model/write_model.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => context.read<BasicModel>().onWillPop(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: context.read<BasicModel>().page[context.watch<BasicModel>().i],
          ),
          bottomNavigationBar: const SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(child: BottomItem(Icons.room, 0)),
                Expanded(child: BottomItem(Icons.create, 1)),
              ],
            ),
          )
        )
    );
  }
}


class BottomItem extends StatelessWidget {
  const BottomItem(this.icon,this.index,{Key? key}) : super(key: key);
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool select = (index == context.watch<BasicModel>().i);
    return GestureDetector(
      onTap: () async {
        context.read<BasicModel>().changeIndex(index);
        if(index == 1){
          try{
            await context.read<WriteModel>().getPosition();
            // ignore: use_build_context_synchronously
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text('위치 정보를 가져오는 데 성공'),
                    actions: [
                      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
                    ],
                  );
                }
            );
          } catch(e){
            // ignore: use_build_context_synchronously
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text(e.toString()),
                    actions: [
                      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
                    ],
                  );
                }
            );
          }
        }
      },
      child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Icon(icon,color: select? Colors.black : Colors.grey,)
      ),
    );
  }
}


/*
class BottomCenterItem extends StatelessWidget {
  const BottomCenterItem(this.index, {Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    bool select = (index == context.watch<BasicModel>().i);
    return GestureDetector(
      onTap: () async{
        context.read<BasicModel>().changeIndex(index);
        if(index == 1){
          try{
            await context.read<WriteModel>().getPosition();
            // ignore: use_build_context_synchronously
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text('위치 정보를 가져오는 데 성공'),
                    actions: [
                      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
                    ],
                  );
                }
            );
          } catch(e){
            // ignore: use_build_context_synchronously
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text(e.toString()),
                    actions: [
                      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
                    ],
                  );
                }
            );
          }
        }
      },
      child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          child: Icon(Icons.pets,size: 40, color: select? Colors.black : Colors.grey,)
      ),
    );
  }
}


 */

