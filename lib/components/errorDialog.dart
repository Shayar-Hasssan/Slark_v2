import 'package:flutter/material.dart';
import 'package:slark_v2/constraints.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ErrorDialogue extends StatefulWidget {
  const ErrorDialogue({Key? key}) : super(key: key);

  @override
  _ErrorDialogueState createState() => _ErrorDialogueState();
}

class _ErrorDialogueState extends State<ErrorDialogue> {
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
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Text(
                        'Warning!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Error Message ....',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
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
                            "Yes",
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
                backgroundColor: Colors.red,
                radius: 40.0,
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 40.0,
                )),
            top: -30,
          )
        ],
      ),
    );
  }
}
