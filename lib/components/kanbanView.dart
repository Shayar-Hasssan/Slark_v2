import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:slark_v2/components/newTaskToCard.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/models/boardItem.dart';
import 'package:slark_v2/models/boardList.dart';

class KanbanView extends StatefulWidget {
  const KanbanView({Key? key}) : super(key: key);

  @override
  _KanbanViewState createState() => _KanbanViewState();
}

class _KanbanViewState extends State<KanbanView> {
  final List<BoardListObject> _listData = [
    BoardListObject(title: 'Planning', items: [
      BoardItemObject(title: 'Task Name 1', from: 'Member 2'),
      BoardItemObject(title: 'Task Name 5', from: 'Member 1'),
    ]),
    BoardListObject(title: 'To-Do', items: [
      BoardItemObject(title: 'Task Name 3', from: 'Member 4'),
      BoardItemObject(title: 'Task Name 2', from: 'Member 3'),
    ]),
    BoardListObject(title: 'Completed', items: [
      BoardItemObject(title: 'Task Name 4', from: 'Member 5'),
    ]),
  ];
  final BoardViewController boardViewController = new BoardViewController();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<BoardList> _lists = <BoardList>[];
    for (var i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]));
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 30, 8, 8),
      child: BoardView(
        lists: _lists,
        boardViewController: boardViewController,
      ),
    );
  }

  BoardList _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (var i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]));
    }
    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldlistIndex) {
        var list = _listData[oldlistIndex!];
        _listData.removeAt(oldlistIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Colors.transparent,
      backgroundColor: Color(0xffECEDFC),
      header: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  list.title,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2f334b),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => TaskToCard(
                              title: list.title,
                            ));
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ],
      items: items,
    );
  }

  BoardItem buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldlistIndex,
          int? oldItemIndex, BoardItemState state) {
        var item = _listData[oldlistIndex!].items![oldItemIndex!];
        _listData[oldlistIndex].items!.removeAt(oldItemIndex);
        _listData[listIndex!].items!.insert(itemIndex!, item);
      },
      onTapItem:
          (int? listIndex, int? itemIndex, BoardItemState state) async {},
      item: Container(
        margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: Card(
          elevation: 0.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemObject.title,
                  style: TextStyle(
                      height: 1.5,
                      color: Color(0xff2F334B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  itemObject.from,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.5,
                    color: kPrimaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
