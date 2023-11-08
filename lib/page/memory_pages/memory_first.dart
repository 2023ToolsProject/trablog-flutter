import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/memory_pages/memory_second.dart';
import 'package:trablog/page/memory_pages/write_page.dart';
import 'package:trablog/view_model/memory_model.dart';
import 'package:trablog/view_model/write_model.dart';

class MemoryFirst extends StatelessWidget {
  const MemoryFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(width: 10,);
    return Column(
      children: [
        Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider(
                                          create: (context) => WriteModel(),
                                          child: const WritePage(),
                                        ))
                                    );
                                  },
                                  child: const Icon(Icons.flight_takeoff)
                              ),
                              space,
                              const Icon(Icons.more_vert),
                              space
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: SizedBox(
                          width: 200,
                          height: 80,
                          child: Image.asset('assets/text/my_trablog.png')
                      )
                  )
                ],
              ),
            )
        ),
        Expanded(
            flex: 4,
            child: PageView.builder(
                controller: context.read<MemoryModel>().con,
                itemCount: 3,
                //itemCount: context.watch<MemoryModel>().data?.length ?? 0,
                itemBuilder: (context, i){
                  return Post(i);
                }
            )
        )
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post(this.index,{Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('2023. 07. 13 ~ 2023. 07. 16'),
          Container(
            width: 250,
            height: 500,
            color: Colors.grey.shade300,
            child: Center(
              child: GestureDetector(
                onTap: (){
                  context.read<MemoryModel>().setIndex(index);
                  var mm = context.read<MemoryModel>().mm;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeNotifierProvider(
                      create: (context)=> mm,
                      child: const MemorySecond(),
                  )));
                },
                child: Container(
                  width: 220,
                  height: 450,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


// person outline, flight takeoff, more vert