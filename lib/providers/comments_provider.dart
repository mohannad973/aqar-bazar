import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class CommentsProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();
  SessionManager sessionManager = SessionManager();

  CommentsResponse commentsResponse = CommentsResponse();
  List<Comment> commentsList = [];

  Future<CommentsResponse> getComments(

      int pageNumber, String propertyId) async {


    print("tcomment response ");
    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
      commentsResponse = await api.getComments(propertyId, pageNumber,token,cookie);

      if (commentsResponse != null) {

        commentsList.clear();

        setLoading(false);



        commentsList.addAll(commentsResponse.data);

        print("modified list "+commentsList[0].comment);
        return commentsResponse;
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
