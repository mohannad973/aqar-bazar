

import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class ForgetPasswordProvider with ChangeNotifier {
  bool loading = false;


  int statusCode =-1;

  Api api = Api();

  SessionManager sessionManager = SessionManager();

  SuccessStringResponse succsessResponse = SuccessStringResponse();


  Future<bool> forgetPass(String email) async {

    succsessResponse = null;
    setLoading(true);
    try {

      succsessResponse = await api.forgetPassword(email);

      setStatusCode(200);
      if (succsessResponse != null) {


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

  void setStatusCode(int value) {
    statusCode = value;
    notifyListeners();
  }

  int getStatusCode() {
    return statusCode;
  }
}
