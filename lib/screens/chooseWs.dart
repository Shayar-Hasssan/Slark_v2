import 'package:flutter/material.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/constraints.dart';

class ChooseWs extends StatefulWidget {
  const ChooseWs({Key? key}) : super(key: key);

  @override
  _ChooseWsState createState() => _ChooseWsState();
}

class _ChooseWsState extends State<ChooseWs> {
  List<String> worskspaces = ['ws1', 'ws2', 'ws3'];
  // List<Item>? _data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          centerTitle: true,
          title: Column(
            children: [
              SizedBox(height: 33.0),
              Text('Where to go?'),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: wS.length,
          itemBuilder: (BuildContext ctx, int index) => EntryItem(
            wS[index],
          ),
        ),
      ),
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> wS = <Entry>[
  Entry('workspacename1', <Entry>[
    Entry('Space11'),
    Entry('Space12'),
    Entry('Space13'),
    Entry('Space14'),
    Entry('Space15'),
  ]),
  Entry('workspacename2', <Entry>[
    Entry('Space21'),
    Entry('Space22'),
  ]),
  Entry('workspacename3', <Entry>[
    Entry('Space31'),
    Entry('Space32'),
    Entry('Space33'),
    Entry('Space34'),
  ]),
  Entry('workspacename4', <Entry>[
    Entry('Space41'),
    Entry('Space42'),
    Entry('Space43'),
  ]),
  Entry('workspacename5', <Entry>[
    Entry('Space51'),
  ]),
];
