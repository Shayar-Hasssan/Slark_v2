import 'package:flutter/material.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class NewSpace extends StatefulWidget {
  NewSpace(this.workspaceid, {Key? key}) : super(key: key);
  final String workspaceid;
  TextEditingController nameController = new TextEditingController();
  @override
  _NewSpaceState createState() => _NewSpaceState();
}

class _NewSpaceState extends State<NewSpace> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'New Space',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: widget.nameController,
                    ),
                    SizedBox(
                      height: 15.0,
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
                            style: TextStyle(color: Colors.red, fontSize: 18.0),
                          ),
                        ),
                        FlatButton(
                          // color: kPrimaryColor,
                          onPressed: () {
                            print(MediaQuery.of(context).size.height);
                            print(MediaQuery.of(context).size.height / 2);
                            bloc
                                .f_PostSpace(context, widget.workspaceid,
                                    widget.nameController.text)
                                .then((value) {
                              if (value.code! > 0) {
                                Navigator.of(context).pop();
                              }
                            });
                            print(widget.nameController.text);
                          },
                          child: Text(
                            "Create",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 18.0),
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
    );
  }
}

// final List<Entry> teams = <Entry>[
//   Entry('Teams', <Entry>[
//     Entry('Team1'),
//     Entry('Team2'),
//     Entry('Team3'),
//     Entry('Team4'),
//   ]),
// ];
