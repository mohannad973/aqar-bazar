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

class ShowAllPropertiesProvider with ChangeNotifier {
  bool loading = false;

  bool firstLoad = false;

  Api api = Api();

  List<Datum> propertiesList = [];

  SearchResultResponse searchResultModel = SearchResultResponse();

  SessionManager sessionManager = SessionManager();

  Future<SearchResultResponse> getAllProperties(int page) async {
    int page2 = page;
    print('page test :'+ page.toString());
    if (page == 1) {
      setFirstLoad(true);
      propertiesList.clear();
    }
    else{
      setLoading(true);
    }


    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
      String lang = await sessionManager.getLang() ==null?'en':await sessionManager.getLang();
      String currency = await sessionManager.getCurrency()==null?"USD": await sessionManager.getCurrency();



      searchResultModel = await api.getAllProperties( cookie, page,lang,currency);

      // while(page2 <= searchResultModel.meta.lastPage){
      //
      //   searchResultModel = await api.getAllProperties(cookie, page2,lang);
      //   allProperties.addAll(searchResultModel.data);
      //     notifyListeners();
      //   page2+=1;
      // }

      if (searchResultModel != null) {
        propertiesList.addAll(searchResultModel.data);

        print('show '+propertiesList.toString());
        // notifyListeners();

        // for(Datum d in allProperties){
        //   print('new list of property :'+d.id.toString());
        // }




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
