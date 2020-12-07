import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_comment_model.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/notification_response_model.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class NotificationProvider with ChangeNotifier {
  bool loading = false;


  Api api = Api();

  List<NotificationResponse> allNotification = [];


  SessionManager sessionManager = SessionManager();

  Future<bool> getNotes() async {

      setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();


      allNotification = await api.getNotification(token);

      print('all notes55 '+allNotification.toString());


      if (allNotification != null || allNotification.isNotEmpty) {


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
