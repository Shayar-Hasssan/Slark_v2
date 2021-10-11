import 'package:flutter/material.dart';
import 'package:slark_v2/constraints.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SuccessDialogue extends StatefulWidget {
  const SuccessDialogue({Key? key}) : super(key: key);

  @override
  _SuccessDialogueState createState() => _SuccessDialogueState();
}

class _SuccessDialogueState extends State<SuccessDialogue> {
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
                        'Your Process Succeeded!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          // color: kPrimaryColor,
                          onPressed: () {
                            print(MediaQuery.of(context).size.height);
                            print(MediaQuery.of(context).size.height / 2);
                          },
                          child: Text(
                            "OK",
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
                backgroundColor: kPrimaryColor,
                radius: 40.0,
                child: Icon(
                  Icons.check,
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
