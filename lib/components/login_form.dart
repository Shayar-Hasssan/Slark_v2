import 'package:flutter/material.dart';
import 'package:slark_v2/components/rounded_button.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/components/rounded_password_input.dart';
import 'package:slark_v2/screens/mainScreen.dart';
import 'package:slark_v2/screens/splash.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
                RoundedInput(
                  icon: Icons.mail,
                  hint: 'Email',
                ),
                RoundedPasswordInput(
                  hint: 'Password',
                ),
                SizedBox(height: 10.0),
                RoundedButton(
                    title: 'LOGIN',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
