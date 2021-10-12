import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slark_v2/components/deleteDialog.dart';
import 'package:slark_v2/models/HomeModel.dart';

class Spaces extends StatefulWidget {
  const Spaces(this.spaces1, {Key? key}) : super(key: key);
  final List<Space> spaces1;
  @override
  _SpacesState createState() => _SpacesState();
}

class _SpacesState extends State<Spaces> {
  var spaces = [
    'spaceyy',
    'space n',
    'space jk',
    'space bm',
    'SSppp',
    'spaceyy',
    'space n',
    'space jk',
    'space bm',
    'SSppp'
  ];
  // var spaces = [];
  @override
  Widget build(BuildContext context) => spaces.isEmpty
      ? Text('NO Spaces Yet')
      : ListView.builder(
          itemCount: widget.spaces1.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(5.0),
                child:
                    // Text(
                    // 'calculateDistanceToLeftBorder: return how many months between the fromDate and the starting point of the presenting project. If it had been already started before the fromDate, it will be display just at the left border with the remaining length.calculateDistanceToLeftBorder: return how many months between the fromDate and the starting point of the presenting project. If it had been already started before the fromDate, it will be display just at the left border with the remaining length.calculateDistanceToLeftBorder: return how many months between the fromDate and the starting point of the presenting project. If it had been already started before the fromDate, it will be display just at the left border with the remaining length.calculateDistanceToLeftBorder: return how many months between the fromDate and the starting point of the presenting project. If it had been already started before the fromDate, it will be display just at the left border with the remaining length.'),
                    Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white54)),
                  child: ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.spaces1[index].name}'),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    DeleteDialogue());
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  )),
                ));
          });
}
