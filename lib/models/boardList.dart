import 'package:slark_v2/models/boardItem.dart';

class BoardListObject {
  String title;
  List<BoardItemObject>? items;
  BoardListObject({this.items, required this.title});
}
