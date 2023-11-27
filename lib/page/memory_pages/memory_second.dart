import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/const/const_value.dart';
import 'package:trablog/page/memory_pages/modify_page.dart';
import 'package:trablog/view_model/memory_model.dart';
import 'package:trablog/view_model/write_model.dart';

class MemorySecond extends StatelessWidget {
  const MemorySecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5182af),
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
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ChangeNotifierProvider(
                                            create: (context) => WriteModel(),
                                            child: const ModifyPage(),
                                          )
                                      ));
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
                      AnimatedSwitcher(
                        transitionBuilder: (widget, animation){
                          var rotate = Tween(begin: pi, end: 0.0).animate(animation);
                          return AnimatedBuilder(
                              animation: rotate,
                              builder: (context, widget){
                                final value = min(rotate.value, pi/2);
                                var tilt = value / 2000;
                                tilt *= rotate.status == AnimationStatus.forward? -1 : 1;
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                                  child: widget,
                                );
                              },
                              child: widget
                          );
                        },
                        duration: const Duration(milliseconds: 500),
                        child: context.watch<MemoryModel>().isBack?
                        Container(
                          key: const ValueKey<int>(1),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          width: double.infinity,
                          height: double.infinity,
                          color: const Color(0xffd9d9d9),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                  child: ListView(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.all(10),
                                          child: Text(context.read<MemoryModel>().clickedData['title'] + '\n' + context.read<MemoryModel>().clickedData['content'],style: const TextStyle(fontSize: 20),)
                                      )
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: SizedBox(
                                      width: 150,
                                      child: Image.asset("assets/text/logYD.png")
                                  )
                              )
                            ],
                          )
                        ) :
                        Container(
                          key: const ValueKey<int>(0),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          color: const Color(0xfff5f5f5),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: context.read<MemoryModel>().clickedData['boardImages'].length,
                            itemBuilder: (context, i){
                              return GestureDetector(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return GestureDetector(
                                            onTap: (){Navigator.pop(context);},
                                            child: Image.network(BASE_IMAGE_URL + context.read<MemoryModel>().clickedData['boardImages'][i]['filePath'])
                                        );
                                      });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.network(BASE_IMAGE_URL + context.read<MemoryModel>().clickedData['boardImages'][i]['filePath'],fit: BoxFit.fill,),
                                ),
                              );
                            }
                         ),
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
                              color: context.watch<MemoryModel>().isBack? const Color(0xfff5f5f5) : const Color(0xffd9d9d9),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: context.watch<MemoryModel>().isBack? const Text('Back',style: TextStyle(fontWeight: FontWeight.bold),) : const Text('Preview',style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ),
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
