import 'package:flutter/material.dart';
import 'package:trablog/page/sign_pages/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/sign_pages/sign_up_page.dart';
import 'package:trablog/view_model/sign_model.dart';
import 'package:trablog/view_model/title_model.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const empty = SizedBox(height: 20,);

    return WillPopScope(
      onWillPop: () async => context.read<TitleModel>().onWillPop(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/cat/cat2.png')
              )
            ),
            child: Column(
              children: [
                const Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('The Best Time',style: TextStyle(fontSize: 30,color: Colors.white),),
                        empty,
                        Text('For You',style: TextStyle(fontSize: 30,color: Colors.white)),
                        empty,
                        Text('To Travel',style: TextStyle(fontSize: 30,color: Colors.white)),
                      ]
                    )
                ),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(
                                create: (context)=>SignModel(TextEditingController(), TextEditingController()),
                                child: const SignInPage(),
                            )));
                          },
                          child: const TitleButton('Sign In'),
                        ),
                        empty,
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(
                                  create: (context)=>SignModel(TextEditingController(), TextEditingController(), con3: TextEditingController()),
                                  child: const SignUpPage(),
                              )));
                            },
                            child: const TitleButton('Sign Up')
                        )
                      ],
                    )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  const TitleButton(this.msg,{Key? key}) : super(key: key);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(child: Text(msg,style: const TextStyle(fontSize: 20))),
    );
  }
}

