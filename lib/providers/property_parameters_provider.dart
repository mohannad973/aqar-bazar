import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/property_parameters_model.dart';
import 'package:aqar_bazar/screens/settings/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PropertyParametersProvider with ChangeNotifier {
  bool loading = false;

  Api api = new Api();

  SessionManager sessionManager = SessionManager();

  PropertyParametersModel propertyParametersModel = PropertyParametersModel();
  List<Category> categoriesList = [];

  Future<PropertyParametersModel> getPropertyParameters() async {
    setLoading(true);
    try {
      String lang = await sessionManager.getLang();

      int langId;

      switch (lang) {
        case "en":
          langId = 1;
          break;
        case "ar":
          langId = 2;
          break;
        case "tr":
          langId = 3;
          break;
        default:
          langId = 1;
          break;
      }

      Response response = await api.getPropertyParameters(langId);

      categoriesList.clear();

      print('categories 26 ' + response.toString());

      if (response != null) {
        propertyParametersModel =
            propertyParametersModelFromJson(response.body);

        for (int i = 0; i < propertyParametersModel.categories.length; i++) {
          categoriesList.add(Category(
              name: propertyParametersModel.categories[i][0],
              id: propertyParametersModel.categories[i][1]));
        }
        print('categories 262 ' + propertyParametersModel.toString());

        setLoading(false);
        return propertyParametersModel;
      }

      if (propertyParametersModel == null) {
        print('categories 263 ' + propertyParametersModel.toString());
        setLoading(false);

        return propertyParametersModel;
      }
      setLoading(false);
      return propertyParametersModel;
    } catch (e) {
      print('categories 264 ' + e.toString());
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
