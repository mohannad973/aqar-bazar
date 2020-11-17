import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class LogInProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();

  SessionManager sessionManager = SessionManager();

  Future<bool> logIn(String email, String password) async {
    print('22222222');
    setLoading(true);

    try {
      print('3333333');
      //Todo DAta Connection Checker
      // String cookie = await sessionManager.getSessionToken();
      SignInResponse user = await api.login(email, password);

      if (user != null) {
        print('44444');
        sessionManager.setAuthToken(user.accessToken);
        setLoading(false);

        print("token is :" + user.accessToken.substring(1070,user.accessToken.length));

        return true;
      }

      print('5555555');
      setLoading(false);
      return false;
    } catch (e) {
      print('66666'+e.toString());
      setLoading(false);
      return false;
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }
}
