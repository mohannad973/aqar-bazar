import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_comment_model.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class AddComentProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();
  AddCommentResponse addCommentResponse;

  SessionManager sessionManager = SessionManager();

  String message;

  Future<AddCommentResponse> addComment(String id ,String comment) async {
    setLoading(true);
    try {
      print('add222 '+isLoading().toString());
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();


      addCommentResponse = await api.addComment(token,id,cookie,comment);

      print('add111 '+addCommentResponse.toString());

      if (addCommentResponse != null) {

        message = addCommentResponse.success;

        setLoading(false);
        return addCommentResponse;
      }


      setLoading(false);
      return null;
    } catch (e) {
      print('add333 ' + e.toString());

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
