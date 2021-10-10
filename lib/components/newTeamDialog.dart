import 'package:flutter/material.dart';

class NewTeam extends StatefulWidget {
  const NewTeam({Key? key}) : super(key: key);

  @override
  _NewTeamState createState() => _NewTeamState();
}

class _NewTeamState extends State<NewTeam> {
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
