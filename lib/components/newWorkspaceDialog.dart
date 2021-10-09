import 'package:flutter/material.dart';

class NewWS extends StatefulWidget {
  const NewWS({Key? key}) : super(key: key);

  @override
  _NewWSState createState() => _NewWSState();
}

class _NewWSState extends State<NewWS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('New Workspace'),
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
