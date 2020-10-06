import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchResultProvider with ChangeNotifier {
  bool loading = false;

  Api api = new Api();
  SearchResultModel searchResult = SearchResultModel();

  Future<SearchResultModel> search(
      {String furnished,
      String type,
      String city,
      String rooms,
      String bathrooms,
      String category,
      String price,
      String capacity}) async {
    setLoading(true);
    try {
      Response response = await api.search(
          furnished: furnished,
          type: type,
          city: city,
          rooms: rooms,
          bathrooms: bathrooms,
          category: category,
          price: price,
          capacity: capacity);

      if (response != null) {
        searchResult = searchResultModeFromJson(response.body);

        setLoading(false);
        return searchResult;
      }

      if (searchResult == null) {
        setLoading(false);

        return searchResult;
      }
      setLoading(false);
      return searchResult;
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
