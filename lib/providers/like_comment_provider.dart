import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/like_comment_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class LikeCommentProvider with ChangeNotifier {
  bool loading = false;

  Api api = Api();
  SessionManager sessionManager = SessionManager();
  LikeComentResponse likeComentResponse = LikeComentResponse();

  String likeBtn = 'like';

  bool success = false;


  Future<LikeComentResponse> likeComment(
      String commentId,) async {

    setLoading(true);
    try {
      String token = await sessionManager.getAuthToken();
      String cookie = await sessionManager.getSessionToken();
      likeComentResponse = await api.likeComment(commentId, token , cookie);



      print('like comment '+ likeComentResponse.toString());

      if (likeComentResponse != null) {

        likeBtn = likeComentResponse.btn;
        setLoading(false);

        return likeComentResponse;
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
