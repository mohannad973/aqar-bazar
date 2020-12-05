import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/contact_us_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class DateProvider with ChangeNotifier {


  String fromDate='';
  String toDate='';



  void setFromDate(String value) {
    fromDate = value;
    notifyListeners();
  }

  String getFromDate() {
    return fromDate;
  }

  void setToDate(String value) {
    toDate = value;
    notifyListeners();
  }

  String getToDate() {
    return toDate;
  }
}
