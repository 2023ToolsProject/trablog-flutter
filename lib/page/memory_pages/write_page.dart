import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/write_model.dart';

class WritePage extends StatelessWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                  children: [
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Text('New Post',style: TextStyle(fontSize: 25),),
                        )
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: GestureDetector(
                              onTap: (){
                                context.read<WriteModel>().post();
                              },
                              child: const Text('Post',style: TextStyle(fontSize: 25),)
                          ),
                        )
                    ),
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: Divider(thickness: 1.5,)
                    )
                  ],
              )
            ),
            SizedBox(
              height: 350,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       GestureDetector(
                         onTap: () async{
                           try {
                             await context.read<WriteModel>().getXImage();
                           }catch(e){
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
                         },
                         child: Container(
                           margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                           height: 150,
                           width: double.infinity,
                           color: Colors.grey.shade300,
                           child: const Icon(Icons.camera_alt,color: Color(0xff666666),),
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                         height: 150,
                         width: double.infinity,
                         color: Colors.grey.shade300,
                         child: TextFormField(
                           controller: context.read<WriteModel>().textCon,
                           maxLines: 10,
                           decoration: const InputDecoration(
                             border: InputBorder.none,
                             hintText: '문구 입력...'
                           ),
                         ),
                       )
                     ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Divider(thickness: 1.5,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: context.watch<WriteModel>().img?.length ?? 0,
                        itemBuilder: (context, i){
                          return Container(
                              width: 50,
                              margin: const EdgeInsets.all(5),
                              child: Image.file(File(context.watch<WriteModel>().img![i].path))
                          );
                        }
                  ),
                    )
                  ],
                )
            )
          ],
        )
      ),
    );
  }
}
