import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/filter/property_params_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchParamsProvider with ChangeNotifier {
  bool loading = false;

  Api api = new Api();
  SessionManager sessionManager = SessionManager();
  SearchParamsModel searchParams = SearchParamsModel();
  List<City> cityList = [];
  List<PriceRanges> pricesList = [];
  List<SellingTypes> sellingTypesList = [];
  List<Furnished> furnishedList = [];
  List<Capacity> capacityList = [];
  List<PropertyType> propertyTypeList = [];

  Future<SearchParamsModel> getSearchParams() async {
    setLoading(true);
    try {
      String lang = await sessionManager.getLang();
      Response response = await api.getSearchParameters(lang);


      pricesList.clear();
      cityList.clear();
      sellingTypesList.clear();
      furnishedList.clear();
      capacityList.clear();
      propertyTypeList.clear();

      if(response != null){
        searchParams = searchParamsModelFromJson(response.body);
        for (int i = 0; i < searchParams.cities.length; i++) {
          cityList.add(City(
              name: searchParams.cities[i][0], id: searchParams.cities[i][1]));
        }
        for (int i = 0; i < searchParams.priceRanges.length; i++) {
          pricesList.add(PriceRanges(range: searchParams.priceRanges[i][0]));
        }

        for (int i = 0; i < searchParams.sellingTypes.length; i++) {
          sellingTypesList.add(SellingTypes(
              name: searchParams.sellingTypes[i][0],
              id: searchParams.sellingTypes[i][1]));
        }

        print('sellingTypesList1 '+sellingTypesList.toString());

        for (int i = 0; i < searchParams.furnished.length; i++) {
          furnishedList.add(Furnished(
              name: searchParams.furnished[i][0],
              id: searchParams.furnished[i][1]));
        }
        print('sellingTypesList2 '+furnishedList.toString());

        for (int i = 0; i < searchParams.capacity.length; i++) {
          capacityList.add(Capacity(
              roomNumber: searchParams.capacity[i][0],
              value: searchParams.capacity[i][1]));
        }

        for (int i = 0; i < searchParams.propertyType.length; i++) {
          propertyTypeList.add(PropertyType(
              name: searchParams.propertyType[i][0],
              id: searchParams.propertyType[i][1]));
        }

        print('sell type tst '+sellingTypesList.toString());
        setLoading(false);
        return searchParams;
      }

      if (searchParams == null) {
        setLoading(false);

        return searchParams;
      }
      setLoading(false);
      return searchParams;
    } catch (e) {
      setLoading(false);
      print("provider /*****************/*/*/*/**" + e.toString());
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
