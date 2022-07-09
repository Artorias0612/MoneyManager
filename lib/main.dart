// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:money_manager_app/models/Money_model.dart';
import 'package:money_manager_app/screens/home_screen.dart';
import 'package:money_manager_app/screens/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async { 
  
  await Hive.initFlutter();
  Hive.registerAdapter(MoneymodelAdapter());
  await Hive.openBox<Money_model>('MoneyBox');
  runApp(const money_manager_app());
}

class money_manager_app extends StatelessWidget {
  const money_manager_app({Key? key}) : super(key: key);

  
  static void getData() {

    HomeScreen.moneys.clear();
    Box<Money_model> hiveBox = Hive.box<Money_model>('MoneyBox');
    for (var value in hiveBox.values){

      HomeScreen.moneys.add(value);
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'ir_sans'),
      debugShowCheckedModeBanner: false,
      title: 'Money Manager App',
      home: const MainScreen(),
    );
  }
}