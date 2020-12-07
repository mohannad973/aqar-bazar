import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CategoryListProvider with ChangeNotifier {
  bool loading = false;
  bool firstLoad = false;

  Api api = new Api();

  SessionManager sessionManager = SessionManager();

  List<Datum> data = [];

  SearchResultResponse searchResult = SearchResultResponse();

  List<Datum> filterData = [];

  Future<SearchResultResponse> getPropertyByType(
      {String category, int page}) async {
    if (page == 1) {
      print('pagination1'+page.toString());
      setFirstLoad(true);
      data.clear();
    } else {
      print('pagination2'+page.toString());
      setLoading(true);
    }

    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
      String lang = await sessionManager.getLang();
      String currency = await sessionManager.getCurrency() == null
          ? "USD"
          : await sessionManager.getCurrency();

      Response response = await api.searchByPropertyType(
        propertyType: category.toString(),
        token: token,
        cookie: cookie,
        lang: lang,
        page: page,
        currency:currency
      );

      if (response != null && page == 1) {
        searchResult = searchResultModeFromJson(response.body);

        data = searchResult.data;
        notifyListeners();

        if (page == 1) {
          setFirstLoad(false);
        } else {
          setLoading(false);
        }
        return searchResult;
      }else if(response != null && page>1){
        searchResult = searchResultModeFromJson(response.body);

        data .addAll(searchResult.data);
        notifyListeners();

        if (page == 1) {
          setFirstLoad(false);
        } else {
          setLoading(false);
        }
        return searchResult;

      }

      if (searchResult == null) {
        if (page == 1) {
          setFirstLoad(false);
        } else {
          setLoading(false);
        }

        notifyListeners();
        return searchResult;
      }

      if (page == 1) {
        setFirstLoad(false);
      } else {
        setLoading(false);
      }
      return searchResult;
    } catch (e) {
      notifyListeners();
      if (page == 1) {
        setFirstLoad(false);
      } else {
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
