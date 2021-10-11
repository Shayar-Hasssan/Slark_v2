import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class TaskToCard extends StatefulWidget {
  const TaskToCard({Key? key, required this.title}) : super(key: key);

  @override
  _TaskToCardState createState() => _TaskToCardState();
  final String title;
}

class _TaskToCardState extends State<TaskToCard> {
  List<String> tasks = ['task1', 'task2', 'task3', 'task4'];
  var selectedTask = 'Select a Task';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'Add Task to ${widget.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90.0,
                    ),
                    DropdownSearch<String>.multiSelection(
                      validator: (List<String>? v) {
                        return v == null || v.isEmpty ? "required field" : null;
                      },
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Select Tasks",
                        labelText: "Select Tasks",
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      showSelectedItems: false,
                      items: ["Task3", "Task7", "Task2", 'Task6'],
                      showClearButton: true,
                      onChange: print,
                      popupSelectionWidget:
                          (cnt, String item, bool isSelected) {
                        return isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green[500],
                              )
                            : Container();
                      },
                      clearButtonSplashRadius: 20,
                      showSearchBox: true,
                    ),
                    SizedBox(
                      height: 55.0,
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
                          },
                          child: Text(
                            'Add',
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

class UserMode {
  String id;
  String name;
  UserMode({required this.id, required this.name});
}
