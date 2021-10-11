import 'package:flutter/material.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/rounded_button.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/components/rounded_password_input.dart';
import 'package:slark_v2/screens/mainScreen.dart';
import 'package:slark_v2/screens/splash.dart';

import '../constraints.dart';
import 'input_container.dart';

class LoginForm extends StatefulWidget {
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

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: widget.size.width,
            height: widget.defaultLoginSize,
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
                    controller: emailController,
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
                    controller: passwordController,
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
                      bloc
                          .f_login(context, emailController.text,
                              passwordController.text)
                          .then((value) {
                        if (value.code! > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen(
                                      value.data!.first.userid ?? "")));
                        } else {
                          print("error");
                        }
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
