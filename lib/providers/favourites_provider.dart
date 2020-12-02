import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/favourites_response.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class FavouritesProvider with ChangeNotifier {
  bool loading = false;
  bool firstLoad = false;

  Api api = new Api();

  SessionManager sessionManager = SessionManager();

  List<Datum> data = [];




  UserFavouritesResponse userFavouritesResponse = UserFavouritesResponse();



  Future<UserFavouritesResponse> getFav(
      { int page}) async {

    if (page == 1) {
      setFirstLoad(true);
      data.clear();
    }
    else{
      setLoading(true);
    }

    try {
      print('fav1');
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
      String lang = await sessionManager.getLang();
      String currency = await sessionManager.getCurrency()==null?"USD": await sessionManager.getCurrency();

      Response response = await api.getFavourites(
          token: token,
          cookie: cookie,
          lang: lang,
          page: page,
      currency:currency);

      print('fav4 '+response.body);
      print('fav5 '+response.statusCode.toString());

      if (response != null) {
        userFavouritesResponse = (userFavouritesResponseFromJson(response.body));
        if(page ==1){
          data = userFavouritesResponse.data;
        }else{
          data.addAll(userFavouritesResponse.data);
        }



        notifyListeners();

        if (page == 1) {
          setFirstLoad(false);
        }else{
          setLoading(false);
        }
        return userFavouritesResponse;
      }

      if (userFavouritesResponse == null) {
        if (page == 1) {
          setFirstLoad(false);
        }else{
          setLoading(false);
        }

        notifyListeners();
        return userFavouritesResponse;
      }

      if (page == 1) {
        setFirstLoad(false);
      }else{
        setLoading(false);
      }
      return userFavouritesResponse;
    } catch (e) {
      print('fav6 '+e.toString());
      notifyListeners();
      if (page == 1) {
        setFirstLoad(false);
      }else{
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

  void removeElement(int index){
    data.removeAt(index);
    notifyListeners();
  }


}
