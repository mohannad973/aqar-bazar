import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class CancelRequestProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();
  CancelRequestResponse cancelRequestResponse;

  SessionManager sessionManager = SessionManager();

  String message;

  Future<CancelRequestResponse> cancelRequest(String id ,) async {
    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();


      cancelRequestResponse = await api.cancelRequest(token,id,cookie);

      if (cancelRequestResponse != null) {

        message = cancelRequestResponse.message;

        setLoading(false);
        return cancelRequestResponse;
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
}
