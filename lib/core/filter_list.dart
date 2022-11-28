import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/money/model/record_money_model.dart';

class FilterList {
  static List<RecordMoneyModel> filterByCatogery(
      List<RecordMoneyModel> list, String catogery, String date) {
    if (catogery == AppString.all) {
      return list
          .where((element) =>
              filterByDate(catogeryDate: date, dateTime: element.dateTime))
          .toList();
    }
    return list
        .where((element) =>
            element.category == catogery &&
            filterByDate(catogeryDate: date, dateTime: element.dateTime))
        .toList();
  }

  static bool filterByDate(
      {required String catogeryDate, required DateTime dateTime}) {
    switch (catogeryDate) {
      case AppString.tody:
        return dateTime.day == DateTime.now().day;
      case AppString.week:
        return DateTime.now().day - dateTime.day <=
            7; //if less than 8 day in date now then it in the week
      case AppString.month:
        return dateTime.month == DateTime.now().month;
      case AppString.year:
        return dateTime.year == DateTime.now().year;

      default:
        return false;
    }
  }

//for statitics page
  static int getAmountByCatogery(
      String catogery, List<RecordMoneyModel> list, String date) {
    if (date != AppString.all) {
      list = list
          .where((element) =>
              filterByDate(catogeryDate: date, dateTime: element.dateTime))
          .toList();
    }
    int amount = 0;
    for (var element in list) {
      if (!element.isIncomeMoney && element.category == catogery) {
        amount += element.money;
      }
    }
    return amount;
  }

  static int getTheExpancAmount(List<RecordMoneyModel> list) {
    int amount = 0;

    for (RecordMoneyModel x in list) {
      if (!x.isIncomeMoney) {
        amount += x.money;
      }
    }

    return amount;
  }

  static int getTheTotalAmount(List<RecordMoneyModel> list) {
    return getTheIncomAmount(list) - getTheExpancAmount(list);
  }

  static int getTheIncomAmount(List<RecordMoneyModel> list) {
    int amount = 0;

    for (RecordMoneyModel x in list) {
      if (x.isIncomeMoney) {
        amount += x.money;
      }
    }

    return amount;
  }

  //for get icome amount in last month
  static int getTheIncomAmountMonth(List<RecordMoneyModel> list) {
    int amount = 0;

    for (RecordMoneyModel x in list) {
      if (x.isIncomeMoney && x.dateTime.month == DateTime.now().month) {
        amount += x.money;
      }
    }

    return amount;
  }
}
