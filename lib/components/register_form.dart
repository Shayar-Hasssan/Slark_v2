import 'package:flutter/material.dart';
import 'package:slark_v2/components/rounded_button.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/components/rounded_password_input.dart';
import 'package:slark_v2/screens/verify.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
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
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
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
                  // SizedBox(
                  //   height: 35,
                  // ),

                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Container(
                    height: 150,
                    child: Image.asset('assets/images/Slarkk.svg'),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  // SizedBox(height: 25.0),
                  RoundedInput(
                    icon: Icons.mail,
                    hint: 'Email',
                  ),
                  RoundedInput(
                    icon: Icons.face_rounded,
                    hint: 'Name',
                  ),
                  RoundedPasswordInput(
                    hint: 'Password',
                  ),
                  SizedBox(height: 10.0),
                  RoundedButton(
                      title: 'SIGN UP',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyScreen()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
