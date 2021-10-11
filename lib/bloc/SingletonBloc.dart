import 'package:rxdart/rxdart.dart';
import 'package:slark_v2/API_Provider/API.dart';
import 'package:slark_v2/models/loginModel.dart';
import 'package:slark_v2/models/workSpaceList.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  BehaviorSubject<WorkSpaceList> _showAllWorkSpaceListController =
      BehaviorSubject();
  Stream<WorkSpaceList> get getAllWorkSpaceListsStream =>
      _showAllWorkSpaceListController.stream;

  factory SingletonBloc() {
    return _singletonBloc;
  }

  SingletonBloc._internal() {
    print('_internal');
  }

  Future<LoginModel> f_login(context, String username, String password) async =>
      await apiProvider.Login(context, username, password).then((value) async {
        return value;
      });

  f_showallworkspaces(context, String userid) async {
    print('f_showallworkspaces');
    await apiProvider.showallworkspaces(context, userid).then((value) {
      _showAllWorkSpaceListController.sink.add(value);
    });
  }
}

final bloc = SingletonBloc();
