import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/components/newTaskDialog.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class NewProject extends StatefulWidget {
  NewProject(this.workspaceid, this.spaceid, {Key? key}) : super(key: key);
  final String workspaceid;
  final String spaceid;
  TextEditingController namecontroller = new TextEditingController();
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  List<DropdownMenuItem> teams = [];
  String selectedvalue = "";

  @override
  void initState() {
    super.initState();
    bloc.f_getteam(context, widget.workspaceid).then((value) {
      for (var ttype in value.data!) {
        setState(() {
          teams.add(
            DropdownMenuItem(
              child: Text(
                ttype.name ?? "",
              ),
              value: ttype.id,
            ),
          );
        });
      }
    });
  }

  List<String> teamMembers = ['Team1', 'Team2', 'Team3'];
  DateTime selectedDate = DateTime.now();
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
              height: MediaQuery.of(context).size.height - 300,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'New Project',
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
                      controller: widget.namecontroller,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      height: 100.0,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          hint: Text(
                            "teams",
                          ),
                          items: teams.map((value) {
                            return DropdownMenuItem(
                              value: value.value,
                              child: value.child,
                            );
                          }).toList(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 15,
                          ),
                          value: selectedvalue == "" ? null : selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              selectedvalue = value;
                            });
                          },
                        ),
                      ),
                    ),

                    // ignore: deprecated_member_use
                    RaisedButton.icon(
                      elevation: 00,
                      color: Colors.transparent,
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.amber,
                      ),
                      label: Text(
                        'Select Due Date',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ignore: deprecated_member_use
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
                        // ignore: deprecated_member_use
                        FlatButton(
                          // color: kPrimaryColor,
                          onPressed: () {
                            print(MediaQuery.of(context).size.height);
                            print(MediaQuery.of(context).size.height / 2);
                            bloc
                                .f_PostProject(
                                    context,
                                    widget.spaceid,
                                    widget.namecontroller.text,
                                    selectedvalue,
                                    selectedDate.toString())
                                .then((value) {
                              if (value.code! > 0) {
                                Navigator.of(context).pop();
                              }
                            });
                            print(widget.namecontroller.text);
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) => NewTask());
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    print(selectedDate);
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
