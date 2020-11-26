import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/contact_us_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class PaymentProvider with ChangeNotifier {
  bool loading = false;
  Api api = Api();

  SessionManager sessionManager = SessionManager();

  String html;

  Future<bool> pay(String propertyId , String amount) async {
    setLoading(true);
    try {

      html = await api.pay(propertyId , amount  );

      print("not null html "+html);

      if (html != null) {
        print("not null html "+html);
        setLoading(false);
        return true;
      }

      setLoading(false);
      return false;
    } catch (e) {
      print("errrrrr70"+ e.toString());
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
