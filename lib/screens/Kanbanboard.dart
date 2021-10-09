import 'package:flutter/material.dart';
import 'package:slark_v2/components/kanbanView.dart';
import 'package:slark_v2/components/customAppbar.dart';
import 'package:slark_v2/constraints.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard({Key? key}) : super(key: key);

  @override
  _KanbanBoardState createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          title: 'Project Name',
        ),
      ),
      body: KanbanView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.receipt),
      ),
    );
  }
}
