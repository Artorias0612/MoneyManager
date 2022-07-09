// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:money_manager_app/constant.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/models/Money_model.dart';
import 'package:money_manager_app/screens/newtransaction_screen.dart';
import 'package:money_manager_app/utils/extension.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<Money_model> moneys = [];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  Box<Money_model> hiveBox = Hive.box<Money_model>('MoneyBox');
  @override
  void initState(){
    money_manager_app.getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        floatingActionButton: fabWidget(context),

        body: SizedBox(

          width: double.infinity,
          child: Column(

            children: [
              headerWidget(),
              Expanded(
                child: ListView.builder(
                  itemCount: HomeScreen.moneys.length,
                  itemBuilder: (contex, index) {
                    return GestureDetector(
                      onLongPress: () {

                        hiveBox.deleteAt(index);
                        money_manager_app.getData();
                        setState(() {});
                      },
                      onTap: () {
                        // Editing a Transaction
                        NewTransactionScreen.titleController.text = HomeScreen.moneys[index].title;
                        NewTransactionScreen.descriptionController.text = HomeScreen.moneys[index].discription;
                        NewTransactionScreen.priceController.text = HomeScreen.moneys[index].price;
                        NewTransactionScreen.isEditing = true;
                        NewTransactionScreen.date = HomeScreen.moneys[index].date;
                        NewTransactionScreen.index = HomeScreen.moneys[index].id;
                        if (HomeScreen.moneys[index].isReceived == true){
                          NewTransactionScreen.groupId = 2;
                        } else {
                          NewTransactionScreen.groupId = 1;
                        }
                        Navigator.push(context, MaterialPageRoute(
                          builder: ((context) => const NewTransactionScreen()
                        ))).then((value) {
                          money_manager_app.getData();
                          setState(() {});});
                      },
                      child: ListTileWidget(index: index)
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Floating Action Button That add a New transaction
  Widget fabWidget(BuildContext context) {
    return FloatingActionButton(

        elevation: 0,
        onPressed: () {
          NewTransactionScreen.date = 'تاریخ';
          NewTransactionScreen.titleController.text = '';
          NewTransactionScreen.descriptionController.text = '';
          NewTransactionScreen.priceController.text = '';
          NewTransactionScreen.groupId = 0;
          NewTransactionScreen.isEditing = false;
          Navigator.push(context, MaterialPageRoute(builder: (context) => 
            const NewTransactionScreen()
          )).then((value) {
            money_manager_app.getData();
            setState(() {});
          });
        },
        backgroundColor: kPurpleColor,
        child: const Icon(Icons.add),
      );
  }
  // Search Bar and Header is hear
  Widget headerWidget () {

  return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
      child: Row(

        children: [
          Expanded(
            child: SearchBarAnimation(
              hintText: 'جستجو کنید...',
              buttonElevation: 0,
              buttonShadowColour: Colors.black26,
              buttonBorderColour: Colors.black26,
              textEditingController: searchController,
              isOriginalAnimation: false,
              onCollapseComplete: () {
                money_manager_app.getData();
                searchController.text = '';
                setState(() {});
              },
              onFieldSubmitted: (String text) {

                List<Money_model> result = hiveBox.values.where(
                  (value) => value.title.contains(text) ||
                    value.date.contains(text)
                ).toList();
                HomeScreen.moneys.clear();
                setState(() {
                  for (var value in result) {
                    HomeScreen.moneys.add(value);
                  }
                });
              },
          )),
          const SizedBox(width: 10,),
          Text(
            'تراکنش ها',
            style: TextStyle(
              fontSize: ScreenSize(context).screenWidth < 1004 
              ? 21.0
              : ScreenSize(context).screenWidth * 0.01,
              fontWeight: FontWeight.bold
            ),),
        ],
      ),
    );
}
}
class ListTileWidget extends StatefulWidget {

  final int index;
  const ListTileWidget({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HomeScreen.moneys[widget.index].isReceived ? kGreenColor : kRedColor,
                borderRadius: BorderRadius.circular(15.5)
              ),
              child: Center(
                child: Icon(
                  HomeScreen.moneys[widget.index].isReceived ? Icons.add : Icons.remove,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 13),
              child: Text(
                HomeScreen.moneys[widget.index].title,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenSize(context).screenWidth < 1004 
                    ? 18.0
                    : ScreenSize(context).screenWidth * 0.01
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'تومان',
                      style: TextStyle(
                        color: HomeScreen.moneys[widget.index].isReceived 
                          ? kGreenColor 
                          : kRedColor,
                        fontSize: ScreenSize(context).screenWidth < 1004
                          ? 18.0
                          : ScreenSize(context).screenWidth * 0.012,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 2,),
                    Text(
                      HomeScreen.moneys[widget.index].price,
                      style: TextStyle(
                        color: HomeScreen.moneys[widget.index].isReceived ? kGreenColor : kRedColor,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenSize(context).screenWidth < 1004
                          ? 18.0
                          : ScreenSize(context).screenWidth * 0.012
                      ),
                    )
                  ],
                ),
                Text(
                  HomeScreen.moneys[widget.index].date,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenSize(context).screenWidth < 1004
                      ? 16.0
                      : ScreenSize(context).screenWidth * 0.012
                  ),
                )
              ],
            )
          ],
        ),
      );
  }
}