import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/sign_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 20);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(30),
                child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('Sign Up',style: TextStyle(fontSize: 40),)
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Form(
                  key: context.read<SignModel>().key,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text('Enter your Email & Password',style: TextStyle(fontSize: 20),),
                      ),
                      space,
                      TextForm('Email',context.read<SignModel>().con1),
                      space,
                      TextForm('Password',context.read<SignModel>().con2,obscure: true,),
                      space,
                      TextForm('Password',context.read<SignModel>().con3!,obscure: true,
                        vali: (value){
                          if(value != context.read<SignModel>().con2.text){
                            return '비밀번호가 다릅니다';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
            ),
            Flexible(
                flex: 2,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  color: Colors.grey.shade300,
                  child: GestureDetector(
                      onTap: () async{
                        if(await context.read<SignModel>().signUp()){
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: const Center(child: Text('Sign Up',style: TextStyle(fontSize: 20),))
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  const TextForm(this._str,this.con,{Key? key, this.obscure = false, this.vali}) : super(key: key);
  final String _str;
  final TextEditingController con;
  final bool obscure;
  final vali;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      color: Colors.grey.shade300,
      height: 60,
      width: double.infinity,
      child: TextFormField(
        controller: con,
        obscureText: obscure,
        style: const TextStyle(fontSize: 20),
        validator: vali,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _str,
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0)
        ),
      ),
    );
  }
}

