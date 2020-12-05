import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/book_success_response.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class BookPropertyProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();

  bool requested= false;
  BookSuccessResponse succressResponse;

  SessionManager sessionManager = SessionManager();


  String message;

  Future<bool> bookProperty(String id ,String from , String to , String amount,String sellType) async {
    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();

      succressResponse = await api.bookProperty(token,id,cookie,from,to,amount,sellType);

      print('book response '+succressResponse.toString());


      if (succressResponse != null) {

        setRequested(true);

        setLoading(false);
        return true;
      }


      setLoading(false);
      return false;
    } catch (e) {
      print('book4 '+e.toString());
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


  void setRequested(bool value) {
    requested = value;
    notifyListeners();
  }

  bool isRequested() {
    return requested;
  }
}
