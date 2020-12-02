

import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_to_fav_response.dart';
import 'package:aqar_bazar/models/favourites_response.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class AddToFavProvider with ChangeNotifier {
  bool loading = false;
  Api api = new Api();

  SessionManager sessionManager = SessionManager();

  AddToFavResponse addToFavResponse = AddToFavResponse();

  Future<bool> addToFav(String propertyId) async {
    setLoading(true);

    try {

      String token = await sessionManager.getAuthToken();

      Response response = await api.addToFav(
          token: token, propertyId: propertyId);


      if (response != null && response.statusCode == 200) {
        addToFavResponse =
            (addToFavResponseFromJson(response.body));


        notifyListeners();

      setLoading(false);
        return true;
      }

      if (addToFavResponse == null) {
        setLoading(false);

        notifyListeners();
        return false;
      }

      setLoading(false);
      return false;
    } catch (e) {
      print('fav6 ' + e.toString());
      notifyListeners();
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
