

import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/reset_password_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class ResetPasswordProvider with ChangeNotifier {
  bool loading = false;


  int statusCode =-1;

  Api api = Api();

  SessionManager sessionManager = SessionManager();

  String resetPasswordResponse;


  Future<bool> resetPass(String code , String password , String cPassword) async {

    resetPasswordResponse = null;
    setLoading(true);
    try {

      resetPasswordResponse = await api.resetPassword(code,password,cPassword);

      setStatusCode(200);
      if (resetPasswordResponse != null) {


        setLoading(false);


        return true;
      }

      setLoading(false);
      return false;
    } catch (e) {
      print("error 24 "+e.toString());
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

  void setStatusCode(int value) {
    statusCode = value;
    notifyListeners();
  }

  int getStatusCode() {
    return statusCode;
  }
}
