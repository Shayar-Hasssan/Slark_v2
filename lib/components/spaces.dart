import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spaces extends StatefulWidget {
  const Spaces({Key? key}) : super(key: key);

  @override
  _SpacesState createState() => _SpacesState();
}

class _SpacesState extends State<Spaces> {
  // var spaces = ['spaceyy', 'space n', 'space jk', 'space bm'];
  var spaces = [];
  @override
  Widget build(BuildContext context) => spaces.isEmpty
      ? Text('NO Spaces Yet')
      : ListView.builder(
          itemCount: spaces.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(

                  // trailing: Text(
                  //   spaces[index],
                  //   style: TextStyle(color: Colors.green, fontSize: 15),
                  // ),
                  title: Text(spaces[index])),
            );
          });
}
