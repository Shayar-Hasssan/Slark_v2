import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class NewTask extends StatefulWidget {
  const NewTask(this.projid, {Key? key}) : super(key: key);
  final String projid;
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  List<DropdownMenuItem> projectmember = [];
  String selectedvalue = "";
  @override
  void initState() {
    super.initState();
    bloc.f_getteampro(context, widget.projid).then((value) {
      for (var ttype in value.data!) {
        setState(() {
          projectmember.add(
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

  List<String> tasks = ['task1', 'task2', 'task3', 'task4', 'task6'];
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
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              height: MediaQuery.of(context).size.height - 180,
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
                        'New Task',
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
                    TextField(),
                    SizedBox(
                      height: 25.0,
                    ),
                    // Container(
                    //   height: 100.0,
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<dynamic>(
                    //       hint: Text(
                    //         "teams",
                    //       ),
                    //       items: projectmember.map((value) {
                    //         return DropdownMenuItem(
                    //           value: value.value,
                    //           child: value.child,
                    //         );
                    //       }).toList(),
                    //       icon: Icon(
                    //         Icons.keyboard_arrow_down,
                    //         color: Colors.black,
                    //         size: 15,
                    //       ),
                    //       value: selectedvalue == "" ? null : selectedvalue,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedvalue = value;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),

                    Container(
                      height: 90.0,
                      child: ListView.builder(
                        itemCount: teams.length,
                        itemBuilder: (BuildContext ctx, int index) => EntryItem(
                          teams[index],
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
                    SizedBox(height: 10.0),
                    DropdownSearch<String>(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Select Priority",
                        labelText: "Select Priority",
                        contentPadding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: ['1', '2', '3'],
                      showClearButton: true,
                      onChanged: print,
                      clearButtonSplashRadius: 10,
                    ),
                    SizedBox(height: 20.0),
                    DropdownSearch<String>(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Select Dependent Tasks",
                        labelText: "Select Dependent Tasks",
                        contentPadding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: tasks,
                      showClearButton: true,
                      onChanged: print,
                      clearButtonSplashRadius: 10,
                      showSearchBox: true,
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
  Entry('Assign Member', <Entry>[
    Entry('member1'),
    Entry('member2'),
    Entry('member3'),
    Entry('member4'),
  ]),
];
