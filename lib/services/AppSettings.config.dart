import 'package:shared_preferences/shared_preferences.dart';

final Map<String, String> appSettings = {
  "uid": "value1",
  "email": "value2",
  "address":"value3"
};
class Config {
  SharedPreferences prefs;
  final Map<String, String> appSettings = {
    "uid": "value1",
    "email": "value2",
    "address":"value3"
  };
  Config(){
    p();


  }
  void p() async{
    prefs=  await SharedPreferences.getInstance();
    appSettings.update("uid", prefs.get("uid"));
    appSettings.update("email", prefs.get("email"));
    appSettings.update("address", prefs.get("address"));


  }

}


