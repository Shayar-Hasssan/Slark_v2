import 'package:rxdart/rxdart.dart';
import 'package:slark_v2/API_Provider/API.dart';
import 'package:slark_v2/models/GetTeams.dart';
import 'package:slark_v2/models/HomeModel.dart';
import 'package:slark_v2/models/ProjectDetailsModel.dart';
import 'package:slark_v2/models/genrealresp.dart';
import 'package:slark_v2/models/loginModel.dart';
import 'package:slark_v2/models/projectList.dart';
import 'package:slark_v2/models/teamlist.dart';
import 'package:slark_v2/models/workSpaceList.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  BehaviorSubject<WorkSpaceList> _showAllWorkSpaceListController =
      BehaviorSubject();
  Stream<WorkSpaceList> get getAllWorkSpaceListsStream =>
      _showAllWorkSpaceListController.stream;

  BehaviorSubject<HomeModel> _HomeModelController = BehaviorSubject();
  Stream<HomeModel> get HomeModelStream => _HomeModelController.stream;

  BehaviorSubject<ProjectList> _ProjectListController = BehaviorSubject();
  Stream<ProjectList> get ProjectListStream => _ProjectListController.stream;

  BehaviorSubject<ProjectdetailsModel> _projectdetailsController =
      BehaviorSubject();
  Stream<ProjectdetailsModel> get prstream => _projectdetailsController.stream;

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

  Future<Successresp> f_PostSpace(
          context, String wsid, String spacename) async =>
      await apiProvider.PostSpace(context, wsid, spacename).then((value) async {
        return value;
      });

  Future<Successresp> f_PostworkSpace(
          context, String userid, String spacename) async =>
      await apiProvider.PostworkSpace(context, userid, spacename)
          .then((value) async {
        return value;
      });

  Future<Successresp> f_PostProject(context, String spaceid, String projectname,
          String teamid, String datee) async =>
      await apiProvider.PostProject(
              context, spaceid, projectname, teamid, datee)
          .then((value) async {
        return value;
      });

  Future<GetTeamList> f_getteam(context, String workspaceid) async =>
      await apiProvider.getteam(context, workspaceid).then((value) async {
        return value;
      });

  Future<Teamlist> f_getteamlist(context, String workspaceid) async =>
      await apiProvider.getteamlist(context, workspaceid).then((value) async {
        return value;
      });

  Future<Successresp> f_postTeam(context, String wksid, String teamname,
          List<String> membid, String leadid) async =>
      await apiProvider
          .postTeam(context, wksid, teamname, membid, leadid)
          .then((value) async {
        return value;
      });

  f_showallworkspaces(context, String userid) async {
    print('f_showallworkspaces');
    await apiProvider.showallworkspaces(context, userid).then((value) {
      _showAllWorkSpaceListController.sink.add(value);
    });
  }

  f_allprojects(context, String spid) async {
    print('f_showallworkspaces');
    await apiProvider.allprojects(context, spid).then((value) {
      _ProjectListController.sink.add(value);
    });
  }

  f_activeprojects(context, String spid) async {
    print('f_showallworkspaces');
    await apiProvider.activeprojects(context, spid).then((value) {
      _ProjectListController.sink.add(value);
    });
  }

  f_completedprojects(context, String spid) async {
    print('f_showallworkspaces');
    await apiProvider.completedprojects(context, spid).then((value) {
      _ProjectListController.sink.add(value);
    });
  }

  f_projectdetails(context, String pid) async {
    print('f_showallworkspaces');
    await apiProvider.prdetails(context, pid).then((value) {
      _projectdetailsController.sink.add(value);
    });
  }

  f_showHome(context, String userid, String wkid, String spaceid) async {
    print('f_showHome');
    await apiProvider.showHome(context, userid, wkid, spaceid).then((value) {
      _HomeModelController.sink.add(value);
    });
  }
}

final bloc = SingletonBloc();
