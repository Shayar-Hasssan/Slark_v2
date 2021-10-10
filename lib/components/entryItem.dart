import 'package:flutter/material.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  // ignore: unused_element
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        onTap: () {
          print('Hello there');
        },
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
