import 'dart:convert';

import 'package:agric/widgets/authenticationScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // final String _url = 'http://127.0.0.1:8000/';
  // static String image_crop = 'http://127.0.0.1:8000/media/';
  // static String image_disease = 'http://127.0.0.1:8000/media/';
  // static String image_soil = 'http://127.0.0.1:8000/media/';
  final String _url = 'http://192.168.43.68:8000/';
  static String image_crop = 'http://192.168.43.68:8000/media/';
  static String image_disease = 'http://192.168.43.68:8000/media/';
  static String image_soil = 'http://192.168.43.68:8000/media/';
  // final String _url = 'http://192.168.43.68:5000/';
  // static String image_crop = 'http://192.168.43.68:5000/media/';
  // static String image_disease = 'http://192.168.43.68:5000/media/';
  // static String image_soil = 'http://192.168.43.68:5000/media/';
  // final String _url = 'http://192.168.1.111:5000/';
  // static String image_crop = 'http://192.168.1.111:5000/media/';
  // static String image_disease = 'http://192.168.1.111:5000/media/';
  // static String image_soil = 'http://192.168.1.111:5000/media/';

  var token = '';
  getToken(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var v = sharedPreferences.getString('refresh_token');
    print(v);
    if (v != null) {
      var data = {"refresh": v};
      print(v);
      var res = await http.post(
          Uri.parse(
            _url + 'api/auth/token/refresh/',
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      print('at');
      print(res.statusCode);
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        print(body);
        sharedPreferences.setString("token", body['access']);
        sharedPreferences.setString("refresh_token", body['refresh']);

        // print(v);
        token = 'JWT ' + body['access'];
      } else {
        sharedPreferences.remove('token');
        sharedPreferences.remove('refresh_token');
        sharedPreferences.remove('user');

        // Navigator.of(context).pushReplacementNamed(RouteGenerator.login);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthScreen()));
      }
    }
  }

  loginRequest(
    data,
    apiUrl,
  ) async {
    var fullUrl = _url + apiUrl;
    // print("hey reached here -------------------------------");
    print(fullUrl);
    try {
      print('here in login------------------------');
      return await http.post(
          Uri.parse(
            fullUrl,
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
    } catch (e) {
      print('here in error------------------------');
      print(e);
      return null;
    }
  }

  posData(data, apiUrl, context) async {
    var fullUrl = _url + apiUrl;
    await getToken(context);
    // print(token);
    try {
      print('reached here ---------------------');
      return await http.post(
          Uri.parse(
            fullUrl,
          ),

          // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
          body: jsonEncode(data),
          headers: _setHeaders());
    } catch (e) {
      print(e);
      return null;
    }
  }

  getData(apiUrl, context) async {
    print('here');
    await getToken(context);
    var fullUrl = _url + apiUrl;
    print(token);
    try {
      return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
    } catch (e) {
      print(e);
      return null;
    }
  }

  putData(apiUrl, context) async {
    print('here');
    await getToken(context);
    var fullUrl = _url + apiUrl;
    print(token);
    try {
      return await http.put(Uri.parse(fullUrl), headers: _setHeaders());
    } catch (e) {
      print(e);
      return null;
    }
  }

  // if (sharedPreferences.getString("token") == null) {
  //   Navigator.push(//--------el mastra codes adamprosper99@gmail.com
  //       context, MaterialPageRoute(builder: (context) => SignInScreen()));

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      };
}


// class CallApiDio {

//   final String _url = 'http://128.199.15.73:5500/';

//   posData(data, apiUrl) async {
//     var fullUrl = _url + apiUrl;
//     return await Dio().post(
//         Uri.parse(
//           fullUrl,
//         ),

//         // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
//         body: jsonEncode(data),
//         headers: _setHeaders());
//   }

//   getData(apiUrl) async {
//     var fullUrl = _url + apiUrl;
//     return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
//   }

  

//   _setHeaders() => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };

// }
