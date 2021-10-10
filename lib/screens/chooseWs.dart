import 'package:flutter/material.dart';
import 'package:slark_v2/components/customAppBar.dart';
import 'package:slark_v2/components/entryItem.dart';
import 'package:slark_v2/constraints.dart';

class ChooseWs extends StatefulWidget {
  const ChooseWs({Key? key}) : super(key: key);

  @override
  _ChooseWsState createState() => _ChooseWsState();
}

class _ChooseWsState extends State<ChooseWs> {
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
        child: CustomAppBar(
          title: 'Where to go?',
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
  Entry('ITE WS', <Entry>[
    Entry('HR'),
    Entry('Library'),
    Entry('Professors'),
    Entry('Students'),
    Entry('Employers'),
  ]),
  Entry('Soft WS', <Entry>[
    Entry('Employers'),
    Entry('Managers'),
  ]),
  Entry('FLutter Soft WS', <Entry>[
    Entry('Developers'),
    Entry('QA'),
    Entry('Testers'),
    Entry('Leaders'),
  ]),
  Entry('OrganizationLLC', <Entry>[
    Entry('ERP'),
    Entry('SCM'),
    Entry('CRM'),
  ]),
  Entry('Google LLC', <Entry>[
    Entry('Services'),
  ]),
];
