import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:provider/provider.dart';

class CancelRequestProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();
  CancelRequestResponse cancelRequestResponse;

  SessionManager sessionManager = SessionManager();

  String message;

  Future<bool> cancelRequest(String id ,) async {
    print('cancel1');
    setLoading(true);
    try {
      message ='';
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();


      cancelRequestResponse  = await api.cancelRequest(token, id, cookie);




      if (cancelRequestResponse != null  ) {

        message = cancelRequestResponse.message;

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
