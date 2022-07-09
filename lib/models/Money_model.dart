// ignore_for_file: camel_case_types, file_names

import 'package:hive/hive.dart';

part 'Money_model.g.dart';

@HiveType(typeId: 0)
class Money_model {

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String discription;
  @HiveField(3)
  String price;
  @HiveField(4)
  String date;
  @HiveField(5)
  bool isReceived;
  Money_model({
    required this.id,
    required this.title,
    required this.discription,
    required this.price,
    required this.date,
    required this.isReceived,
  });
}
