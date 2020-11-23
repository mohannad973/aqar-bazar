import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_comment_model.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class AllPropertiesProvider with ChangeNotifier {
  bool loading = false;

  bool firstLoad = false;

  Api api = Api();

  List<Datum> allProperties = [];

  SearchResultModel searchResultModel = SearchResultModel();

  SessionManager sessionManager = SessionManager();

  Future<SearchResultModel> getAllProperties(int page) async {
    print('the page :'+ page.toString());
    if (page == 1) {
      setFirstLoad(true);
      allProperties.clear();
    }
    else{
      setLoading(true);
    }


    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();

      searchResultModel = await api.getAllProperties( cookie, page);

      if (searchResultModel != null) {
        allProperties.addAll(searchResultModel.data);

        for(Datum d in allProperties){
          print('new list of property :'+d.id.toString());
        }




        if (page == 1) {
          setFirstLoad(false);
        }else{
          setLoading(false);
        }

        return searchResultModel;
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
