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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: IconButton(
                                  splashRadius: 0.1,
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.navigate_before,color: Color(0xff666666),size: 40,),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: const Text('Modify',style: TextStyle(fontSize: 20,color: Colors.white),)
                                    ),
                                  )
                              )
                            ],
                          )
                      ),
                      Expanded(
                          child: SizedBox(
                              width: 150,
                              child: Image.asset('assets/text/black_my_trablog.png')
                          )
                      )
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                        color: context.watch<MemoryModel>().isBack? Colors.grey.shade400 : Colors.white,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: 6,
                          itemBuilder: (context, i){
                            return Container(
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
                                  child: context.watch<MemoryModel>().isBack? Container(key: const ValueKey<int>(1), color: Colors.grey.shade400,) : Image.asset(key: const ValueKey<int>(0),'assets/naver.png')
                              ),
                            );
                          }
                    ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: (){
                            context.read<MemoryModel>().flipImage();
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: context.watch<MemoryModel>().isBack? Colors.white : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: context.watch<MemoryModel>().isBack? const Text('Back',style: TextStyle(fontWeight: FontWeight.bold),) : const Text('Preview',style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ),
                      context.watch<MemoryModel>().isBack?
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                            width: 150,
                            child: Image.asset('assets/text/logYD.png')
                        ),
                      )
                          : const Text(''),
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
