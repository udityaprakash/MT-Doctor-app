
import 'dart:convert';

import 'package:http/http.dart'  as http;
import 'package:meditransparency/data/dataflow/api_urls.dart';

import '../../utils/widgets/toastmsg.dart';

dynamic login_in(String mobileno, String password) async {
  try {
    print("login Initiated:");

    String uri = urls.base_url+urls.doctor_route+'/login';    

    final json = {"mobileno": mobileno, "password": password};

    var response = await http.post(Uri.parse(uri),
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"mobileno": mobileno, "password": password}));

     if (response.statusCode == 200) {

        var jsonResponse = jsonDecode(response.body);

        // print('success Response: '+jsonResponse.toString());

        return jsonResponse;

      } else {

        print('Request failed with status: ${response.statusCode}.');
      }
  } catch (err) {
    Toastmsg(msg: 'something went wrong');
    print("error caught: " + err.toString());
  }
}