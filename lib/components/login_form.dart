import 'package:flutter/material.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/rounded_button.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/components/rounded_password_input.dart';
import 'package:slark_v2/screens/mainScreen.dart';
import 'package:slark_v2/screens/splash.dart';

import '../constraints.dart';
import 'input_container.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 1.0 : 0.0,
      duration: animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  child: Image.asset('assets/images/Slarkk.svg'),
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 40.0),
                InputContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail, color: kPrimaryColor),
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                InputContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: kPrimaryColor),
                      hintText: "Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                RoundedButton(
                    title: 'LOGIN',
                    onPressed: () {
                      bloc.f_login(context, emailController.text,
                          passwordController.text);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
