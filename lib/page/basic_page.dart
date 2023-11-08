import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/basic_model.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => context.read<BasicModel>().onWillPop(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                context.read<BasicModel>().page[context.watch<BasicModel>().i],
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.transparent,
                    height: 100,
                    child: const Row(
                      children: [
                        Expanded(child: BottomItem(Icons.room, 0)),
                        Expanded(child: BottomItem(Icons.mode_edit, 1)),
                        Expanded(
                            child: BottomCenterItem(2)
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          /*
          body: context.read<BasicModel>().page[context.watch<BasicModel>().i],
          bottomNavigationBar: Container(
            color: Colors.transparent,
            height: 100,
            child: const Row(
              children: [
                Expanded(child: BottomItem(Icons.room, 0)),
                Expanded(child: BottomItem(Icons.mode_edit, 1)),
                Expanded(
                    child: BottomCenterItem(2)
                )
              ],
            ),
          ),
          */
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
    return Column(
      children: [
        Expanded(child: Container(color: Colors.transparent,)),
        Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: (){
                context.read<BasicModel>().changeIndex(index);
              },
              child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Icon(icon,color: select? Colors.black : Colors.grey,)
              ),
            )
        )
      ],
    );
  }
}
class BottomCenterItem extends StatelessWidget {
  const BottomCenterItem(this.index, {Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    bool select = (index == context.watch<BasicModel>().i);
    return GestureDetector(
      onTap: (){
        context.read<BasicModel>().changeIndex(index);
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


