import 'package:money_managment_app/core/strings_manager.dart';

class RecordMoneyModel {
  final int money;
  final String category;
  final bool isIncomeMoney;
  final String desciption;
  DateTime dateTime;
  RecordMoneyModel(
      {required this.isIncomeMoney,
      required this.category,
      required this.dateTime,
      required this.desciption,
      required this.money});

  @override
  String toString() {
    return "$category, $money , $isIncomeMoney ";
  }
}

List<String> categoryList = [
  AppString.food,
  AppString.shopping,
  AppString.salary,
  AppString.subscription,
  AppString.gifts,
  AppString.internet,
];
List<RecordMoneyModel> myList = [
  RecordMoneyModel(
    isIncomeMoney: false,
    category: categoryList[0],
    dateTime: DateTime.utc(2022, 10, 9),
    desciption: "testin description",
    money: 150,
  ),
  RecordMoneyModel(
    isIncomeMoney: false,
    category: categoryList[1],
    dateTime: DateTime.utc(2022, 11, 9),
    desciption: "test description",
    money: 6000,
  ),
  RecordMoneyModel(
    isIncomeMoney: true,
    category: categoryList[1],
    dateTime: DateTime.utc(2022, 11, 9),
    desciption: "test description",
    money: 7000,
  ),
];
final List<String> listFilterDate = [
  AppString.tody,
  AppString.week,
  AppString.month,
  AppString.year
];
