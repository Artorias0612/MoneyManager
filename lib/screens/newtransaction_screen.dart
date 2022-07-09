// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last, unrelated_type_equality_checks
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/constant.dart';
import 'package:money_manager_app/main.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/Money_model.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({Key? key}) : super(key: key);
  static int groupId = 0;
  static bool isEditing = false;
  static int index = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController titleController = TextEditingController();
  static String date = 'تاریخ';
  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}
class _NewTransactionScreenState extends State<NewTransactionScreen> {
  Box<Money_model> hiveBox = Hive.box<Money_model>('MoneyBox');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomAppBar(),
              const SizedBox(
                height: 30.0,
              ),
              TextFieldWidget(hinttext: 'عنوان', controller: NewTransactionScreen.titleController),
              const SizedBox(
                height: 27,
              ),
              TextFieldWidget(hinttext: 'توضیحات', controller: NewTransactionScreen.descriptionController,),
              const SizedBox(
                height: 27,
              ),
              TextFieldWidget(hinttext: 'مبلغ', type: TextInputType.number,controller: NewTransactionScreen.priceController,),
              const SizedBox(
                height: 15,
              ),
              const TypeAndDataWidget(),
              const SizedBox(
                height: 35,
              ),
              Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    Money_model item = Money_model(
                      id: Random().nextInt(9999),
                      title: NewTransactionScreen.titleController.text,
                      discription: NewTransactionScreen.descriptionController.text,
                      price: NewTransactionScreen.priceController.text,
                      date: NewTransactionScreen.date,
                      isReceived: 
                        NewTransactionScreen.groupId == 1 ? false : true
                    );
                    if (NewTransactionScreen.titleController == ''|| NewTransactionScreen.descriptionController.text == '' || NewTransactionScreen.priceController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "لطفا اطلاعات را کامل وارد کنید",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                          elevation: 0,
                          backgroundColor: kPurpleColor,
                          padding: EdgeInsets.all(10.5),
                        )
                      );
                    }
                    else {
                      if (NewTransactionScreen.isEditing){
                      int realindex = 0;
                      money_manager_app.getData();
                      for (int i = 0; i < hiveBox.values.length; i++){
                        if (hiveBox.values.elementAt(i).id ==
                              NewTransactionScreen.index){
                                realindex = i;
                              }
                      }
                      hiveBox.putAt(realindex, item);
                    } else {
                      hiveBox.add(item);
                    }}
                    Navigator.pop(context);
                  },
                  child: Text(NewTransactionScreen.isEditing ? 'ویرایش تراکنش' : 'ثبت تراکنش'),
                  style: TextButton.styleFrom(
                    backgroundColor: kPurpleColor,
                    elevation: 0,
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
class TypeAndDataWidget extends StatefulWidget {
  const TypeAndDataWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<TypeAndDataWidget> createState() => _TypeAndDataWidgetState();
}
class _TypeAndDataWidgetState extends State<TypeAndDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RadioWidget(
            value: 1,
            groupvalue: NewTransactionScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionScreen.groupId = value!;
              });
            },
            text: 'پرداختی'
          ),
        ),
        Expanded(
          child: RadioWidget(
            value: 2,
            groupvalue: NewTransactionScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionScreen.groupId = value!;
              });
            },
            text: 'دریافتی'
          ),
        ),
        Expanded(child: Container(
          width: 75,
          height: 40,
          margin: const EdgeInsets.only(right: 20, top: 15, left: 5),
          child: OutlinedButton(
            onPressed: () async {
              var pickedDate = await showPersianDatePicker(
                context: context,
                initialDate: Jalali.now(),
                firstDate: Jalali(1400),
                lastDate: Jalali(1499));
              setState(() {
                if (pickedDate == null){
                  NewTransactionScreen.date = 'تاریخ';
                }
                else {
                  String day = pickedDate.day.toString().length == 1
                    ? '0${pickedDate.day.toString()}'
                    : pickedDate.day.toString();
                  String month = pickedDate.month.toString().length == 1
                    ? '0${pickedDate.month.toString()}'
                    : pickedDate.month.toString();
                  String year = pickedDate.year.toString();
                  NewTransactionScreen.date = '$year/$month/$day';
                }
              });
            },
            child: Text(
              NewTransactionScreen.date,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16
              ),
            )
          ),
        )
        ),
      ],
    );
  }
}
class RadioWidget extends StatelessWidget {
  final int value;
  final int groupvalue;
  final Function(int?) onChanged;
  final String text;
  const RadioWidget({
    Key? key,
    required this.value,
    required this.groupvalue,
    required this.onChanged,
    required this.text
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, top: 15, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Radio(
            value: value,
            activeColor: kPurpleColor,
            groupValue: groupvalue,
            onChanged: onChanged
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}
class TextFieldWidget extends StatelessWidget {
  final String hinttext;
  final TextInputType type;
  final TextEditingController controller;
  const TextFieldWidget({
    Key? key,
    required this.hinttext,
    required this.controller,
    this.type = TextInputType.text
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hinttext,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300)
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300)
          )
        ),
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5, left: 12, top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: 12, top: 15, left: 5),
          child: Text(NewTransactionScreen.isEditing ? 'ویرایش تراکنش' : 'تراکنش جدید',
           style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),)),
      ],
    );
  }
}