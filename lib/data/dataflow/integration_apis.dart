import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meditransparency/data/dataflow/api_urls.dart';
import 'package:meditransparency/data/dataflow/devicestorage.dart';

import '../../utils/widgets/toastmsg.dart';

dynamic login_in(String mobileno, String password) async {
  try {
    print("login Initiated:");

    String uri = urls.base_url + urls.doctor_route + '/login';

    final json = {"mobileno": mobileno, "password": password};

    var response = await http.post(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"mobileno": mobileno, "password": password}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      print('success Response: ' + jsonResponse.toString());

      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (err) {
    Toastmsg(msg: 'something went wrong');
    print("error caught: " + err.toString());

    return ();
  }
}

Future<dynamic> patientsinfo() async {
  try {
    log('here');
    await get_patients_list();
    final hospitalid = await StorageManager.readData("current_hospital_id");
    if (hospitalid == null) {
      return "hospital Doesn't Exist";
    } else {
      final patients_info =
          jsonDecode(await StorageManager.readData('current_patients_list'));
      log("all patients Info " + patients_info.toString());
      return patients_info;
    }
  } catch (er) {
    log("error here " + er.toString());
  }
}

Future<dynamic> patientinfofromstorage() async {
  try {
    final hospitalid = await StorageManager.readData("current_hospital_id");
    if (hospitalid == null) {
      return "hospital Doesn't Exist";
    } else {
      final patients_info =
          jsonDecode(await StorageManager.readData('current_patients_list'));
      // log("all patients Info " + patients_info.toString());
      final patientid = await StorageManager.readData('selected_patient');
      var i, index;
      for (i in patients_info['patientsinfo']) {
        if (i["patientid"] == patientid) {
          index = i;
          break;
        }
      }
      // log("patient matched is: " + index.toString());

      return i;
    }
  } catch (er) {
    log("error here " + er.toString());
  }
}

Future<Map<dynamic, dynamic>?> get_patients_list() async {
  try {
    log("setting patients list");
    // SharedPreferences user_info = await SharedPreferences.getInstance();
    Map? patientslists = await patientslist();
    StorageManager.saveData('current_patients_list', jsonEncode(patientslists));
    return patientslists;
  } catch (er) {
    log(er.toString());
  }
}

Future<Map?> patientslist() async {
  try {
    String? token = (await StorageManager.readData('token')).toString();
    log("doctor token is :" + token);
    String? selhospital =
        (await StorageManager.readData('current_hospital_id')).toString();
    log("Initialised Profile get for: " + token);
    final response = await post(
        Uri.parse('https://meditransparency.onrender.com/doctor/patients'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: "Bearer $token",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"hospitalid": selhospital}));
    final Map output = jsonDecode(response.body);
    log("response of the profile : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: in patients list " + er.toString());
  }
}

Future<Map?> doctordetails() async {
  try {
    String? token = (await StorageManager.readData('token')).toString();
    log("doctor token is :" + token);
    // String? selhospital =
    //     (await StorageManager.readData('current_hospital_id')).toString();
    // log("Initialised Profile get for: " + token);
    final response = await get(
        Uri.parse('https://meditransparency.onrender.com/doctor/profiledetails'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: "Bearer $token",
          'Content-Type': 'application/json; charset=UTF-8',
        },);
    final Map output = jsonDecode(response.body);
    log("doctor profile details: " + output.toString());
    return output;
  } catch (er) {
    log("error caught: in patients list " + er.toString());
  }
}

Future<String?> issaveddata() async {
  try {
    final token = await StorageManager.readData('token');
    log("already user is logged in : " + token.toString());

    return token;
  } catch (er) {
    log("error :" + er.toString());
  }
}
