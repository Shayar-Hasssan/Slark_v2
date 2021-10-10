import 'package:flutter/material.dart';

class NewProject extends StatefulWidget {
  const NewProject({Key? key}) : super(key: key);

  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('New Project'),
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
