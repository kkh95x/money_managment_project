// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_managment_app/core/filter_list.dart';
import 'package:money_managment_app/features/money/widgets/global_widgets.dart';
import 'package:provider/provider.dart';

import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/money/controller/money_provider.dart';
import 'package:money_managment_app/features/money/model/record_money_model.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final ValueNotifier<String> _selectedTime =
      ValueNotifier<String>(AppString.tody);
  final ValueNotifier<String> _selecteCatogry =
      ValueNotifier<String>(AppString.all);

  @override
  Widget build(BuildContext context) {
    List<RecordMoneyModel> listMoney = Provider.of<MoneyProvider>(
      context,
    ).getListMoney;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(children: [
        getAppar(onPressed: () {
          Provider.of<MoneyProvider>(context).setPageIndex =
              0; //to back homepage
        }),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            CustomComboBox(
              width: 96,
              selectedTime: _selectedTime,
              list: listFilterDate,
              onChanged: (String value) {
                // print(value);
                setState(() {});
              },
            ),
            const SizedBox(
              width: 15,
            ),
            CustomComboBox(
              width: 120,
              selectedTime: _selecteCatogry,
              list: [AppString.all] + categoryList,
              onChanged: (value) {
                // print(value);
                setState(() {});
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListOfTransaction(
              list: FilterList.filterByCatogery(
                  listMoney, _selecteCatogry.value, _selectedTime.value)),
        ),
      ]),
    );
  }

  Container getComboBox(
      {required ValueNotifier<String> selectedTime,
      required List list,
      required double width,
      required void Function(String value) onChanged}) {
    return Container(
      height: 40,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border:
              Border.all(color: ColorManager.colorBorderInputText, width: 1.0),
          borderRadius: BorderRadius.circular(16)),
      child: ValueListenableBuilder(
        valueListenable: selectedTime,
        builder: (context, value, child) => DropdownButton(
            underline: const SizedBox(),
            style: TextStyle(
              color: ColorManager.headerTextColorLight,
              fontSize: 16,
              fontFamily: INTER_FONT,
              fontWeight: FontWeight.w400,
            ),
            icon: SvgPicture.asset(
              AppImagesPath.comboDownIcon,
              width: 14,
            ),
            borderRadius: BorderRadius.circular(16),
            value: value,
            alignment: Alignment.centerLeft,
            items: list
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            onChanged: ((newvalue) {
              selectedTime.value = newvalue.toString();
              onChanged(newvalue.toString());
            })),
      ),
    );
  }

  PreferredSizeWidget getAppar({required void Function() onPressed}) {
    return AppBar(
        backgroundColor: ColorManager.color1HeaderContainerHomePage,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.black,
          ),
          onPressed: () {
            onPressed();
          },
        ),
        centerTitle: true,
        title: Text(
          AppString.transaction,
          style: TextStyle(
            fontFamily: INTER_FONT,
            fontWeight: FontWeight.w600,
            color: ColorManager.black,
            fontSize: 18,
          ),
        ));
  }
}

class ListOfTransaction extends StatelessWidget {
  List<RecordMoneyModel> list;
  ListOfTransaction({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Build List TranSation Money");

    return ListView.separated(
        itemBuilder: (context, index) {
          bool isIncome = list[index].isIncomeMoney;

          return getItemList(
              list[index].category,
              list[index].desciption,
              (isIncome ? "+ " : "- ") + list[index].money.toString(),
              isIncome ? ColorManager.green : ColorManager.red);
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: list.length);
  }

  Widget getItemList(
      String title, String subTitle, String amount, Color color) {
    return Container(
      height: 89,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: ColorManager.white),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
              color: ColorManager.titleOnTrans,
              fontSize: 16,
              fontFamily: INTER_FONT,
              fontWeight: FontWeight.w400,
            )),
        subtitle: Text(subTitle,
            style: TextStyle(
              color: ColorManager.subTitleOnTrans,
              fontSize: 13,
              fontFamily: INTER_FONT,
              fontWeight: FontWeight.w400,
            )),
        trailing: SizedBox(
          height: 37,
          child: Column(children: [
            Text(amount,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontFamily: INTER_FONT,
                  fontWeight: FontWeight.w600,
                )),
          ]),
        ),
      ),
    );
  }
}
