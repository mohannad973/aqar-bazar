import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_comment_model.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/filter/filter.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class UserRequestProvider with ChangeNotifier {
  bool loading = false;

  bool firstLoad = false;

  Api api = Api();

  List<Request> allRequestsList = [];

  UserRequestsResponse userRequestsResponse = UserRequestsResponse();

  SessionManager sessionManager = SessionManager();

  Future<UserRequestsResponse> getAllRequests(int page) async {
    print('the page :'+ page.toString());
    if (page == 1) {
      setFirstLoad(true);
      allRequestsList.clear();
    }
    else{
      setLoading(true);
    }


    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
       String lang  = await sessionManager.getLang();
      String currency = await sessionManager.getCurrency()==null?"USD": await sessionManager.getCurrency();
       print('lang2 '+lang==null.toString());

      userRequestsResponse = await api.getAllRequests(token, cookie, page,lang,currency);

      if (userRequestsResponse != null) {
        allRequestsList.addAll(userRequestsResponse.request);

        for(Request request in allRequestsList){
          print('new list of request :'+request.id.toString());
        }




        if (page == 1) {
          setFirstLoad(false);
        }else{
          setLoading(false);
        }

        return userRequestsResponse;
      }


      if (page == 1) {
        setFirstLoad(false);
      }else{
        setLoading(false);
      }


      return null;
    } catch (e) {
      print('add333 ' + e.toString());

      if (page == 1) {
        setFirstLoad(false);
      }
      else{
        setLoading(false);
      }


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

  void setFirstLoad(bool value) {
    firstLoad = value;
    notifyListeners();
  }

  bool isFirstLoading() {
    return firstLoad;
  }
}
