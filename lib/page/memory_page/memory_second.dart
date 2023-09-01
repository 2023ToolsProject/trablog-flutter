import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/memory_model.dart';

class MemorySecond extends StatelessWidget {
  const MemorySecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6b8870),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                              splashRadius: 0.1,
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.navigate_before,color: Color(0xff666666),size: 40,),
                            ),
                          )
                      ),
                      Expanded(
                          child: SizedBox(
                              width: 150,
                              child: Image.asset('assets/text/white_my_trablog.png')
                          )
                      )
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: 10,
                        itemBuilder: (context, i){
                          return GestureDetector(
                            onTap: (){
                              context.read<MemoryModel>().flipImage();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: AnimatedSwitcher(
                                  transitionBuilder: (widget, animation){
                                    var rotate = Tween(begin: pi, end: 0.0).animate(animation);
                                    return AnimatedBuilder(
                                        animation: rotate,
                                        builder: (context, widget){

                                          final value = min(rotate.value, pi/2);
                                          return Transform(
                                              transform: Matrix4.rotationY(value),
                                              child: widget,
                                          );
                                        },
                                        child: widget
                                    );
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  child: context.watch<MemoryModel>().isBack? Image.asset(key: const ValueKey<int>(1),'assets/green.png') : Image.asset(key: const ValueKey<int>(0),'assets/naver.png')
                              ),
                            ),
                          );
                        }
                    ),
                      context.watch<MemoryModel>().isBack? const Text('메세지',style: TextStyle(color: Colors.white),) : const Text(''),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
