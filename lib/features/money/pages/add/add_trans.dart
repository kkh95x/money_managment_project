import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_managment_app/features/widgets/app_widget.dart';
import 'package:money_managment_app/features/money/controller/money_provider.dart';

import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/money/model/record_money_model.dart';
import 'package:provider/provider.dart';

class AddTransView extends StatelessWidget {
  AddTransView({super.key});
  String? otherCatogeyInput;

  String? description;
  String? amount;
  String dateTime = DateTime.now().toString();
  final ValueNotifier<String> _catogreySelected =
      ValueNotifier<String>(AppString.food);
  final ValueNotifier<bool> _isIncome = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isOtherSelected = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.color1HeaderContainerHomePage,
      appBar: getAppar(onPressed: () {
        Navigator.of(context).pop(); //back button app bar tap to close the page
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.howMuch,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 18,
                  fontFamily: INTER_FONT,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // name coin
                    SizedBox(
                      height: 60,
                      child: Text(
                        AppString.tl,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontSize: 40,
                          fontFamily: INTER_FONT,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //text filde to number amount
                    SizedBox(
                      height: 60,
                      width: size.width * 0.70,
                      child: TextField(
                        onChanged: ((value) {
                          amount = value;
                        }),
                        style: TextStyle(
                          color: ColorManager.black,
                          fontSize: 40,
                          fontFamily: INTER_FONT,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: AppString.zero,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          //to appled just number
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 42,
                      ),

                      /*


                      Combo box category


                      */
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 57,
                          width: 332,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManager.colorBorderInputText,
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(16)),
                          child: ValueListenableBuilder(
                            valueListenable: _catogreySelected,
                            builder: (context, value, child) => DropdownButton(
                                underline: const SizedBox(),
                                style: TextStyle(
                                  color: ColorManager.headerTextColorLight,
                                  fontSize: 16,
                                  fontFamily: INTER_FONT,
                                  fontWeight: FontWeight.w400,
                                ),
                                icon: SvgPicture.asset(
                                    AppImagesPath.comboDownIcon),
                                borderRadius: BorderRadius.circular(16),
                                value: value,
                                alignment: Alignment.centerLeft,
                                items: getItemsComboBox(
                                    categoryList + [AppString.other]),
                                onChanged: ((newvalue) {
                                  if (newvalue == AppString.other) {
                                    //if user choose other
                                    _isOtherSelected.value =
                                        true; //set it true to build textfiled other
                                  } else {
                                    _isOtherSelected.value =
                                        false; //if user not choose other set value false to hid other fildes
                                  }
                                  // print(_isOtherSelected.value);
                                  _catogreySelected.value =
                                      newvalue ?? AppString.food;
                                })),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      /*
                      
                      Other Input listen to the isOtherSelect when user choose other from combo box is visibal

                      */
                      ValueListenableBuilder(
                        builder: (context, isOther, child) {
                          //print("Other Rebuil");
                          return isOther
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    width: 332,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorManager
                                                .colorBorderInputText,
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: TextField(
                                      onChanged: (newvalue) {
                                        otherCatogeyInput = newvalue;
                                      },
                                      style: TextStyle(
                                        color:
                                            ColorManager.headerTextColorLight,
                                        fontSize: 16,
                                        fontFamily: INTER_FONT,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppString.writeOtherHere,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        },
                        valueListenable: _isOtherSelected,
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      //descripthon Text Filde
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: 332,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManager.colorBorderInputText,
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(16)),
                          child: TextField(
                            onChanged: (value) {
                              description = value;
                            },
                            style: TextStyle(
                              color: ColorManager.headerTextColorLight,
                              fontSize: 16,
                              fontFamily: INTER_FONT,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: AppString.description,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // custom Radio button [income,Expanse] listen to isIncome
                      SizedBox(
                        height: 25,
                        child: ValueListenableBuilder(
                          valueListenable: _isIncome,
                          builder: (context, value, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 81,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: value
                                      ? ColorManager.green
                                      : ColorManager.headerTextColorLight,
                                ),
                                child: InkWell(
                                  onTap: (() {
                                    _isIncome.value =
                                        true; //if click on income set is true
                                  }),
                                  child: Text(
                                    AppString.income,
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 16,
                                      fontFamily: INTER_FONT,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 81,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: value
                                      ? ColorManager.headerTextColorLight
                                      : ColorManager.red,
                                ),
                                child: InkWell(
                                  onTap: (() {
                                    _isIncome.value =
                                        false; //if click in expanse set isIncome false
                                  }),
                                  child: Text(
                                    AppString.expenses,
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 16,
                                      fontFamily: INTER_FONT,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: 332,
                        height: 57,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.colorBorderInputText,
                              width: 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DateTimePicker(
                          style: TextStyle(
                            color: ColorManager.headerTextColorLight,
                            fontSize: 16,
                            fontFamily: INTER_FONT,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          type: DateTimePickerType.date,
                          dateMask: 'd MMM, yyyy',
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          onChanged: (val) {
                            // print(val);
                            dateTime = val;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              MyButton(
                color: ColorManager.foucosedColor,
                name: AppString.continue1,
                textColor: ColorManager.white,
                onTap: (() {
                  if (description == null || amount == null) {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(actions: [
                        Center(
                          child: Text(
                            AppString.showAlterDialogIsEmpty,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: INTER_FONT,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ]),
                    );
                  } else {}
                  Provider.of<MoneyProvider>(context, listen: false)
                      .addRecordMoney(
                          amount: amount!,
                          catogry: _isOtherSelected.value
                              ? otherCatogeyInput ?? AppString.other
                              : _catogreySelected.value,
                          desc: description!,
                          isIncome: _isIncome.value,
                          date: dateTime);

                  Navigator.of(context).pop();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getItemsComboBox(List<String> list) {
    // print("getItemsComboBox ${list}");
    return list
        .map((e) => DropdownMenuItem(
              value: e,
              child: SizedBox(
                width: 272,
                child: Text(
                  e,
                ),
              ),
            ))
        .toList();
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
          AppString.addTransaction,
          style: TextStyle(
            fontFamily: INTER_FONT,
            fontWeight: FontWeight.w600,
            color: ColorManager.black,
            fontSize: 18,
          ),
        ));
  }
}
