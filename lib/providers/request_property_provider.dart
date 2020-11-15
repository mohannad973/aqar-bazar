import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class RequestPropertyProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();

  bool requested= false;
  SuccessStringResponse succressResponse;

  SessionManager sessionManager = SessionManager();

  CancelRequestResponse cancelRequestResponse;

  String message;

  Future<SuccessStringResponse> requestProperty(String id ,) async {
    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();

      print("testing token 3 " +token);
      succressResponse = await api.requestProperty(token,id,cookie);

      if (succressResponse != null) {

        setRequested(true);

        print('111111111111111111 '+ succressResponse.toString());
        setLoading(false);
        return succressResponse;
      }
      print('22222222222 '+ succressResponse.toString());

      setLoading(false);
      return null;
    } catch (e) {
      print('333333333333 '+ e.toString());
      setLoading(false);
      return null;
    }
  }


  Future<CancelRequestResponse> cancelRequest(String id ,) async {
    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();


      cancelRequestResponse = await api.cancelRequest(token,id,cookie);

      if (cancelRequestResponse != null) {

        setRequested(false);

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


  void setRequested(bool value) {
    requested = value;
    notifyListeners();
  }

  bool isRequested() {
    return requested;
  }
}
