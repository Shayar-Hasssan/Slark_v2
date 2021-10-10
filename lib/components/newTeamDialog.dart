import 'package:flutter/material.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/components/input_container.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class NewTeam extends StatefulWidget {
  const NewTeam({Key? key}) : super(key: key);

  @override
  _NewTeamState createState() => _NewTeamState();
}

class _NewTeamState extends State<NewTeam> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                // height: MediaQuery.of(context).size.height / 2,
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          'New Team',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: textColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RoundedInput(
                        hint: 'Team Name',
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Team Members Emails',
                          hintText:
                              'ex. example1@example.com example2@example.com',
                        ),
                      ),
                      // Container(
                      //   height: 100.0,
                      //   child: ListView.builder(
                      //     itemCount: teams.length,
                      //     itemBuilder: (BuildContext ctx, int index) => EntryItem(
                      //       teams[index],
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            // color: Colors.red,
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.0),
                            ),
                          ),
                          FlatButton(
                            // color: kPrimaryColor,
                            onPressed: () {
                              print(MediaQuery.of(context).size.height);
                              print(MediaQuery.of(context).size.height / 2);
                            },
                            child: Text(
                              "Create",
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70.0,
                child: Image(
                  image: AssetImage('assets/images/profile.png'),
                ),
              ),
              top: -75,
            )
          ],
        ),
      ),
    );
  }
}

final List<Entry> teams = <Entry>[
  Entry('Teams', <Entry>[
    Entry('Team1'),
    Entry('Team2'),
    Entry('Team3'),
    Entry('Team4'),
  ]),
];
