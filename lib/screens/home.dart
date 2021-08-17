import 'package:flutter/material.dart';
import 'package:slark_v2/components/drawer.dart';
import 'package:slark_v2/screens/mainScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrawerScreen(),
        MainScreen(),
      ],
    );
  }
}
