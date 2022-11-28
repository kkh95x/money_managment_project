import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_managment_app/features/money/model/record_money_model.dart';

class MoneyProvider with ChangeNotifier {
  // controller the page index editing in bottom navigation bar
  int _pageIndex = 0;
  int get getPageIndex => _pageIndex;
  set setPageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  // list money managment data
  List<RecordMoneyModel> get getListMoney => myList;

  // current index list for filter by [tody,week,month,year]
  int indexFilterOnHomePage = 0;
  int get getIndexFilterOnHomePage => _pageIndex;
  set setIndexFilterOnHomePage(int newIndex) {
    indexFilterOnHomePage = newIndex;

    notifyListeners();
  }

  //get Date Tody from device
  String get getTodayDate {
    DateTime date = DateTime.now();

    String dateFormat = DateFormat('EEEE').format(date);
    dateFormat += " ${date.day}";

    dateFormat += "\n${DateFormat("MMMM").format(date)}";

    return dateFormat.toUpperCase();
  }

  void addRecordMoney({
    required String amount,
    required String catogry,
    required String desc,
    required bool isIncome,
    required String date,
  }) {
    myList.insert(
        0,
        RecordMoneyModel(
          isIncomeMoney: isIncome,
          category: catogry,
          dateTime: DateTime.parse(date),
          desciption: desc,
          money: int.parse(amount),
        ));
    notifyListeners();
  }
}
