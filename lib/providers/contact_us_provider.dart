import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/contact_us_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class ContactUSProvider with ChangeNotifier {
  bool loading = false;
  Api api = Api();

  SessionManager sessionManager = SessionManager();

  ContactUsResponse contactUsResponse = ContactUsResponse();

  String message;

  Future<bool> contactUs(String email, String name, String phone,
      String message) async {
    setLoading(true);
    try {
      //Todo DAta Connection Checker
       contactUsResponse = await api.contactUs(email , name , phone , message );


       print('contact us response : '+contactUsResponse.toString());
      if (contactUsResponse != null) {
        message = contactUsResponse.message;
        setLoading(false);
        return true;
      }

      setLoading(false);
      return false;
    } catch (e) {
      print("errrrrr"+ e.toString());
      setLoading(false);
      return false;
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
