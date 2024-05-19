
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> setBool({required String key,required bool value})async{
    return await sharedPreferences.setBool(key, value);
  }
  static dynamic getData({required String key}){
    return  sharedPreferences.get(key);
  }
  static dynamic saveData({required dynamic value,required String key})async{
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }
  static dynamic removeData({required String key}){
    return sharedPreferences.remove(key);
  }
}