// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:money_manager_app/utils/calculate.dart';
import 'package:money_manager_app/utils/extension.dart';
import 'package:money_manager_app/widgets/chart_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}
class _InfoScreenState extends State<InfoScreen> {
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
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 15, left: 5),
                child: Text(
                  'مدیریت تراکنش ها به تومان',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: ScreenSize(context).screenWidth < 1004 
                      ? 15 
                      : ScreenSize(context).screenWidth * 0.01
                  ),),),
              MoneyInfoWidget(
                firsttext: ' : دریافتی امروز',
                secondtext: ' : پرداختی امروز',
                firstprice: Calculate.rToday().toString(),
                secondprice: Calculate.pToday().toString()),
              MoneyInfoWidget(
                firsttext: ' : دریافتی این ماه',
                secondtext: ' : پرداختی این ماه',
                firstprice: Calculate.rMonth().toString(),
                secondprice: Calculate.pMonth().toString()),
              MoneyInfoWidget(
                firsttext: ' : دریافتی امسال',
                secondtext: ' : پرداختی امسال',
                firstprice: Calculate.rYear().toString(),
                secondprice: Calculate.pYear().toString()),
              const SizedBox(height: 40,),
              Calculate.rYear() == 0 && Calculate.pYear() == 0 
                ? Container() 
                : Container(
                  height: 200,
                  padding: const EdgeInsets.all(20.0),
                  child: const BarChartWidget())
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyInfoWidget extends StatelessWidget {
  final String firsttext;
  final String secondtext;
  final String firstprice;
  final String secondprice;
  
  const MoneyInfoWidget({Key? key, 
    required this.firsttext,
    required this.secondtext,
    required this.firstprice,
    required this.secondprice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontSize = ScreenSize(context).screenWidth * 0.01;
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 20, left: 15),
      child: Row(
    
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              secondprice,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: fontSize < 1004 ? 14 : fontSize),
            )),
          Text(
            secondtext,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: fontSize < 1004 ? 14 : fontSize),),
          Expanded(
            child: Text(
              firstprice,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: fontSize < 1004 ? 14 : fontSize),
            )),
          Text(
            firsttext,
            style: TextStyle(fontSize: fontSize < 1004 ? 14 : fontSize),)
        ],
      ),
    );
  }
}