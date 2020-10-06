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
    setLoading(true);
    try {
      //Todo DAta Connection Checker
      SignInResponse user = await api.login(email, password);
      if (user != null) {
        sessionManager.setAuthToken(user.accessToken);
        setLoading(false);

        print("token:" + user.accessToken);

        return true;
      }

      setLoading(false);
      return false;
    } catch (e) {
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
