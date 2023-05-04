
import 'package:shared_preferences/shared_preferences.dart';





class AppState {
  static AppState? _instance;
  String? authentationCode;
  int? locationCount;
  int? businessCount;
  SharedPreferences? sharePreference;
  List<Map<String,int>>? businessList;
  List<Map<String,int>>? locationList;

  void setData(int locationcount,int businesscount,List<Map<String,int>> businesslist,List<Map<String,int>> locationlist){
      locationCount=locationcount;
      businessCount=businesscount;
      businessList=businesslist;
      locationList=locationlist;
  }


  static AppState getInstance(){
    _instance ??= AppState._privateConstructer();
    return _instance!;
  }  

  AppState._privateConstructer();
}
