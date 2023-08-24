import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/main_page.dart';
import 'package:trablog/view_model/sign_model.dart';

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
                flex: 2,
                child: Container(
                    margin: const EdgeInsets.all(30),
                    child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Sign In', style: TextStyle(fontSize: 40),)
                    )
                )
            ),
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    TextForm('Email', context.read<SignModel>().con1),
                    const SizedBox(height: 20,),
                    TextForm('Password', context.read<SignModel>().con2,obscure: true),
                    const SizedBox(height: 60,),
                    GestureDetector(
                      onTap: () async{
                        if(await context.read<SignModel>().signIn()){
                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const MainPage()
                          ));
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: const Text('로그인 실패'),
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
            Expanded(flex: 2,child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 120,
                    child: const Divider(thickness: 1.5,)
                ),
                const Text('or sign in with',style: TextStyle(fontSize: 20),),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 120,
                    child: const Divider(thickness: 1.5,)
                ),
              ],
            )
            ),
            const Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleIcon('assets/naver.png'),
                    CircleIcon('assets/naver.png'),
                    CircleIcon('assets/naver.png'),
                    CircleIcon('assets/naver.png'),
                    CircleIcon('assets/naver.png'),
                  ],
                )
            )

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

