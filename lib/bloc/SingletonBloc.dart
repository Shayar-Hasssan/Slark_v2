import 'package:slark_v2/API_Provider/API.dart';
import 'package:slark_v2/models/loginModel.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

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
}

final bloc = SingletonBloc();
