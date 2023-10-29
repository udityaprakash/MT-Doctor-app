import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditransparency/data/constants/colors.dart';

void Toastmsg({msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ui.greyclr,
    // textColor: Colors.yellow
  );
}