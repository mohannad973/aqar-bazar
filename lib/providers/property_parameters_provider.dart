
import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/property_parameters_model.dart';
import 'package:aqar_bazar/screens/settings/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PropertyParametersProvider with ChangeNotifier{

  bool loading = false;

  Api api = new Api();

  PropertyParametersModel propertyParametersModel = PropertyParametersModel();
  List<Category> categoriesList = [];



  Future<PropertyParametersModel> getPropertyParameters() async {
    print('test2');
    setLoading(true);
    try {
      Response response = await api.getPropertyParameters();


      categoriesList.clear();


      if(response != null){
        propertyParametersModel = propertyParametersModelFromJson(response.body);

        for (int i = 0; i < propertyParametersModel.categories.length; i++) {
          categoriesList.add(Category(
              name: propertyParametersModel.categories[i][0], id: propertyParametersModel.categories[i][1]));
        }


        setLoading(false);
        return propertyParametersModel;
      }

      if (propertyParametersModel == null) {
        setLoading(false);

        return propertyParametersModel;
      }
      setLoading(false);
      return propertyParametersModel;
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