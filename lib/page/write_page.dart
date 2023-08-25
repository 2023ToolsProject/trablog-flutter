import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/write_model.dart';

class WritePage extends StatelessWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Flexible(
              child: SizedBox(
                height: 80,
                child: Stack(
                    children: [
                      const Center(child: Text('New Post',style: TextStyle(fontSize: 25),)),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: GestureDetector(
                                onTap: (){
                                  print('누름');
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
              )
          ),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Center(
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: 150,
                       width: 150,
                       color: Colors.grey.shade300,
                       child: const Icon(Icons.camera_alt,color: Color(0xff666666),),
                     ),
                     const SizedBox(width: 20,),
                     SizedBox(
                       height: 180,
                       width: 200,
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
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(thickness: 1.5,),
                )
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Container()
          )
        ],
      )
    );
  }
}
