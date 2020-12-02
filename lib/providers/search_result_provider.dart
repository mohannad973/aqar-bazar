import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchResultProvider with ChangeNotifier {
  bool loading = false;
  bool firstLoad = false;

  Api api = new Api();

  SessionManager sessionManager = SessionManager();

  List<Datum> data = [];
  SearchResultResponse searchResult = SearchResultResponse();
  List<Datum> filterData = [];

  Future<SearchResultResponse> search(
      {String furnished,
      String type,
      String city,
      String rooms,
      String bathrooms,
      String category,
      String price,
      String capacity}) async {
    print('test4');
    setLoading(true);

    print("teeeeeeest");
    try {
      String token =await sessionManager.getAuthToken();
      String cookie =await sessionManager.getSessionToken();
      String lang =await sessionManager.getLang();
      String currency = await sessionManager.getCurrency()==null?"USD": await sessionManager.getCurrency();
      print('test5');
      Response response = await api.search(
          furnished: furnished,
          type: type,
          city: city,
          rooms: rooms,
          bathrooms: bathrooms,
          category: category,
          price: price,
          capacity: capacity,
      token: token,
     cookie: cookie,
      lang: lang,
      currency:currency);

      if (response != null) {
        print('test6');
        print('result testing : ' + response.body);
        searchResult = searchResultModeFromJson(response.body);

        data = searchResult.data;
        notifyListeners();

        print("inside the provider 000" + searchResult.toString());
        setLoading(false);
        return searchResult;
      }

      if (searchResult == null) {
        print('test7');
        print("inside the provider 000" + searchResult.toString());
        setLoading(false);

        notifyListeners();
        return searchResult;
      }
      print('test8');
      setLoading(false);
      return searchResult;
    } catch (e) {
      print('test9');
      print("inside the provider 111" + e.toString());
      notifyListeners();
      setLoading(false);
      return null;
    }
  }

  Future<SearchResultResponse> filter(
      {String furnished,
      String type,
      String rooms,
      String price,
      String capacity,
      int page}) async {

    if (page == 1) {
      setFirstLoad(true);
      filterData.clear();
    }
    else{
      setLoading(true);
    }

    try {

      String token =await sessionManager.getAuthToken();
      String cookie =await sessionManager.getSessionToken();
      String lang =await sessionManager.getLang();
      String currency = await sessionManager.getCurrency()==null?"USD": await sessionManager.getCurrency();

      Response response = await api.filter(
          furnished: furnished,
          type: type,
          rooms: rooms,
          price: price,
          capacity: capacity,page: page,  token: token,
          cookie: cookie,
          lang: lang,
      currency:currency);

      if (response != null) {
        print('filter : ' + response.body);
        searchResult = searchResultModeFromJson(response.body);
        filterData = searchResult.data;
        notifyListeners();

        print("inside the provider 000" + searchResult.toString());
        if (page == 1) {
          setFirstLoad(false);
        }else{
          setLoading(false);
        }
        return searchResult;
      }

      if (searchResult == null) {
        print('test7');
        print("inside the provider 000" + searchResult.toString());

        if (page == 1) {
          setFirstLoad(false);
        }else{
          setLoading(false);
        }


        notifyListeners();
        return searchResult;
      }

      if (page == 1) {
        setFirstLoad(false);
      }
      else{
        setLoading(false);
      }
      return searchResult;
    } catch (e) {
      notifyListeners();
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
