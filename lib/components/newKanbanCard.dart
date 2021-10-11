import 'package:flutter/material.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class NewKanbanCard extends StatefulWidget {
  const NewKanbanCard({Key? key}) : super(key: key);

  @override
  _NewKanbanCardState createState() => _NewKanbanCardState();
}

class _NewKanbanCardState extends State<NewKanbanCard> {
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
                        'New Card',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    RoundedInput(
                      hint: 'Card Name',
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: PopupMenuButton(
                          itemBuilder: (context) {
                            return tasks.map((option) {
                              return PopupMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$selectedTask',
                                style:
                                    TextStyle(fontSize: 18.0, color: textColor),
                              ),
                              Icon(Icons.arrow_drop_down, color: textColor),
                            ],
                          ),
                          onSelected: (option) {
                            setState(() {
                              selectedTask = option.toString();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 35.0,
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
