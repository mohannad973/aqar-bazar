
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_comment_model.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/like_comment_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:http/http.dart' as http;


const baseUrl = "https://aqarbazar.com/api";

SessionManager sessionManager = SessionManager();

class Api {
  Future getSearchParameters() {
    var url = baseUrl + "/v1/searchParameters";
    return http.get(url);
  }

  Future search(
      {String furnished,
      String type,
      String city,
      String rooms,
      String bathrooms,
      String category,
      String price,
      String capacity}) {
    print("from api class 989786" + furnished);
    var url = baseUrl + "/v1/search";
    print("uuuuuuuurrrrrrrl" + url);
    return http.post(url);
  }



  Future filter(
      {String furnished,
        String type,
        String rooms,
        String price,
        String capacity,int page}) {
    print("from api class 989786" + furnished);
    var url = baseUrl + "/v1/search?page=$page";
    print("uuuuuuuurrrrrrrl" + url);
    return http.post(url,body: {
      'furnished':furnished,
      'type':type,
      'price_range':price,
      'capacity':capacity,
      'rooms':rooms
    });
  }

  Future getPreferences() {
    var url = baseUrl + "/v1/getPreferences";
    return http.get(url);
  }

  Future getPropertyParameters() {
    print('test3');
    var url = baseUrl + "/v1/propertyParameters";
    return http.get(url);
  }

  Future login(String email, String password) async {
    try {
      print('777777');
     //print('login cookie : '+coo);
      final String apiUrl = baseUrl + '/v1/login';
      final response = await http.post(apiUrl, body: {
        "email": email,
        "password": password
      });


     print('email :' + email+'t');
     print('pass :' + password+'p');
      int index = response.headers['set-cookie'].indexOf(';');
      String cookie = response.headers['set-cookie'].substring(0, index);


      sessionManager.setSessionToken(cookie);
     print('login response :'+response.body);
      print('8888888888');
      if (response.statusCode == 200) {
        final String responseString = response.body;

        return signInResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      print('9999999'+e.toString());
      return null;
    }
  }

  Future register(String email, String password, String firstName,
      String lastName, String passwordConfirm) async {
    try {
      final String apiUrl = baseUrl + '/v1/register';
      final response = await http.post(apiUrl, body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirm
      });

      if (response.statusCode == 201) {
        final String responseString = response.body;

        return registerSuccessResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getUserProfile(String token) async {
    try {
      String url = baseUrl + '/v1/user';

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return userProfileResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getPropertyInfo(String url, String token) async {
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return singlePropertyResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future requestProperty(String token, String id, String cookie) async {
    try {
      String url = baseUrl + '/properties/${id}/requestProperty';
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie,
      });

      print('55555555555  ' + response.body);
      if (response.statusCode == 200) {
        return successStringResponseFromJson(response.body);
      } else {
        print('444444444  ' + response.body);
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future cancelRequest(String token, String id, String cookie) async {
    try {
      String url = baseUrl + '/v1/request/$id/cancel';
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('cancel request ' + response.body);

      if (response.statusCode == 200) {
        return cancelRequestResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getComments(
      String propertId, int pageNumber, String token, String cookie) async {
    try {
      String url =
          baseUrl + '/properties/$propertId/comments?page=${pageNumber}';

      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Cookie': cookie,
      });

      print('comment body ' + response.body.toString());

      if (response.statusCode == 200) {
        return commentsResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future likeComment(String commentId, String token, String cookie) async {
    try {
      String url = baseUrl + '/properties/$commentId/likeComment';

      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie
      });

      if (response.statusCode == 200) {
        return likeComentResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future addComment(
      String token, String id, String cookie, String comment) async {
    try {
      String url = baseUrl + '/properties/$id/makeComment';

      print('testadd1 ' + url);
      final response = await http.post(url, body: {
        'comment': comment
      }, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('testadd2 ' + response.body);

      print('testadd1 ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return addCommentResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getAllRequests(String token, String cookie, int page) async {
    try {
      String url = baseUrl + '/v1/requests?page=$page';

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('all requests1 ' + response.body);

      print('all requests2  ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return userRequestsResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }


  Future contactHost(String token, String cookie, String propertyId,String message) async {
    try {
      String url = baseUrl + '/properties/$propertyId/contactHost';

      final response = await http.post(url,body: {
        'message' : message
      }, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('contact host ' + response.body);
      print('contact host 2' + response.statusCode.toString());


      if (response.statusCode == 200) {
        return successStringResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }



}
