import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:provider/provider.dart';

class LogInProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();

  int status_code ;
  SessionManager sessionManager = SessionManager();


  Future<bool> logIn(String email, String password) async {
    print('22222222');
    setLoading(true);

    try {
      print('3333333');
      //Todo DAta Connection Checker
      // String cookie = await sessionManager.getSessionToken();


      SignInResponse user = await api.login(email, password);



      // Response response = await api.login(email, password);
      //
      // status_code = response.statusCode;
      //
      //  print("satusCode 2: "+i.toString());

      if (user != null) {

        sessionManager.setAuthToken(user.accessToken);
        setLoading(false);


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
