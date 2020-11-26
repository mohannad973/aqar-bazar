import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class NotificationProvider with ChangeNotifier {
  bool loading = false;


  int statusCode =-1;
  Api api = Api();
  SessionManager sessionManager = SessionManager();

  // SuccessStringResponse succsessResponse = SuccessStringResponse();


  Future getNotes() async {

    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
      var res = await api.getNotifications(token, cookie);

      print('res999 '+res.toString());

      setStatusCode(200);
      if (res != null) {


        setLoading(false);


        return res;
      }

      setLoading(false);
      return null;
    } catch (e) {

      setLoading(false);
      return null;
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setStatusCode(int value) {
    statusCode = value;
    notifyListeners();
  }

  int getStatusCode() {
    return statusCode;
  }
}
