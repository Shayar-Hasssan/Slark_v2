import 'package:flutter/material.dart';

class NewSpace extends StatefulWidget {
  const NewSpace({Key? key}) : super(key: key);

  @override
  _NewSpaceState createState() => _NewSpaceState();
}

class _NewSpaceState extends State<NewSpace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('New Space'),
        content: TextFormField(),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text('OK'),
          ),
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cncel')),
        ],
      ),
    );
  }
}
