import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/basic_page.dart';
import 'package:trablog/view_model/map_model.dart';
import 'package:trablog/view_model/memory_model.dart';
import 'package:trablog/view_model/plan_model.dart';
import 'package:trablog/view_model/sign_model.dart';
import 'package:trablog/view_model/basic_model.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SignModel>().signInInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.all(30),
                    child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Sign In', style: TextStyle(fontSize: 40),)
                    )
                )
            ),
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    TextForm('ID', context.read<SignModel>().con1),
                    const SizedBox(height: 20,),
                    TextForm('Password', context.read<SignModel>().con2,obscure: true),
                    const SizedBox(height: 60,),
                    GestureDetector(
                      onTap: () async{
                        try{
                          await context.read<SignModel>().signIn();
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(create: (context)=>BasicModel()),
                                  ChangeNotifierProvider(create: (context)=>PlanModel()),
                                  ChangeNotifierProvider(create: (context)=>MemoryModel()),
                                  ChangeNotifierProvider(create: (context)=>MapModel())
                                ],
                                child: const BasicPage(),
                              )),
                                  (route)=>false
                          );
                        } catch(e){
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: const Text('로그인 정보를 다시 확인하세요'),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: const Text('확인'))
                                  ],
                                );
                              }
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 60,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: const Center(child: Text('Sign In',style: TextStyle(fontSize: 20),)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      height: 30,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 25,
                            child: Checkbox(
                                splashRadius: 0,
                                checkColor: Colors.grey,
                                activeColor: Colors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                    (state)=> const BorderSide(width: 2.0, color: Colors.grey)
                                ),
                                value: context.watch<SignModel>().remember,
                                onChanged: (value){
                                  context.read<SignModel>().rememberEmail();
                                }
                            ),
                          ),
                          const Text('remember me',style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: (){},
                        child: const Text('Forgot Password?',style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
class TextForm extends StatelessWidget {
  const TextForm(this._str,this.con, {Key? key,this.obscure = false}) : super(key: key);
  final String _str;
  final bool obscure;
  final TextEditingController con;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: 60,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: TextFormField(
        controller: con,
        style: const TextStyle(fontSize: 20),
        obscureText: obscure,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: _str,
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0)
        ),
      ),
    );
  }
}


class CircleIcon extends StatelessWidget {
  const CircleIcon(this.image,{Key? key}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}

