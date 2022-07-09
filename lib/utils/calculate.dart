import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:money_manager_app/models/Money_model.dart';

String year = Jalali.now().year.toString();
String month = Jalali.now().month.toString().length == 1 
  ? '0${Jalali.now().month.toString()}'
  : Jalali.now().month.toString();
String day = Jalali.now().day.toString().length == 1 
  ? '0${Jalali.now().day.toString()}'
  : Jalali.now().day.toString();

Box<Money_model> hiveBox = Hive.box<Money_model>('MoneyBox');
class Calculate{
  static String today() {
    return '$year/$month/$day';
  }
  static double pToday() {
    double result = 0;
    for (var value in hiveBox.values){
      if (value.date == today() && value.isReceived == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double pMonth() {
    double result = 0;
    for (var value in hiveBox.values){
      if(value.date.substring(5,7) == month && value.isReceived == false){
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double pYear() {
    double result = 0;
    for (var value in hiveBox.values){
      if (value.date.substring(0,4) == year && value.isReceived == false){
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double rToday() {
    double result = 0;
    for (var value in hiveBox.values){
      if(value.date == today() && value.isReceived){
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double rMonth() {
    double result = 0;
    for (var value in hiveBox.values){
      if (value.date.substring(5,7) == month && value.isReceived){
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double rYear() {
    double result = 0;
    for (var value in hiveBox.values){
      if (value.date.substring(0,4) == year && value.isReceived){
        result += double.parse(value.price);
      }
    }
    return result;
  }
}