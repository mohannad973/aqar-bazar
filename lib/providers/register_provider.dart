import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class RegisterProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();

  SessionManager sessionManager = SessionManager();

  Future<bool> register(String email, String password, String firstName,
      String lastName, String passwordConfirm) async {
    setLoading(true);
    try {
      //Todo DAta Connection Checker
      RegisterSuccessResponse user = await api.register(email , password , firstName , lastName , passwordConfirm);
      print("user registered : "+ user.toString());
      if (user != null) {
        sessionManager.setAuthToken(user.accessToken);
        setLoading(false);
        return true;
      }

      setLoading(false);
      return false;
    } catch (e) {
      print("errrrrr"+ e.toString());
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
