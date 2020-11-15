import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class USerProfileProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();

  UserProfileResponse userProfileResponse = UserProfileResponse();

  SessionManager sessionManager = SessionManager();

  Future<UserProfileResponse> getUserProfile() async {
    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      UserProfileResponse userProfile = await api.getUserProfile(token);
      if (userProfile != null) {
       userProfileResponse = userProfile;
        setLoading(false);


        print("user profile :" + userProfileResponse.toString());

        return userProfileResponse;
      }

      setLoading(false);
      return null;
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
