import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_managment_app/core/filter_list.dart';
import 'package:money_managment_app/features/money/controller/money_provider.dart';
import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/money/model/record_money_model.dart';
import 'package:money_managment_app/features/money/widgets/global_widgets.dart';
import 'package:provider/provider.dart';

class StaticsView extends StatefulWidget {
  const StaticsView({super.key});

  @override
  State<StaticsView> createState() => _StaticsViewState();
}

class _StaticsViewState extends State<StaticsView> {
  //listen combo box
  late ValueNotifier<String> selectedTime;
  //listen custom radio button
  late ValueNotifier<bool> _isIncome;
  // total incomeAmount
  late int incomAmount;
  // total expanseAmount
  late int expanseAmount;
  //list money
  late List<RecordMoneyModel> list;

  //initial varible
  @override
  void initState() {
    super.initState();
    selectedTime = ValueNotifier<String>(AppString.all);
    _isIncome = ValueNotifier<bool>(false);
    list = Provider.of<MoneyProvider>(context, listen: false).getListMoney;

    incomAmount = FilterList.getTheIncomAmount(list);
    expanseAmount = FilterList.getTheExpancAmount(list);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      getAppar(onPressed: () {
        Provider.of<MoneyProvider>(context, listen: false).setPageIndex =
            0; //to home page
      }),
      const SizedBox(
        height: 50,
      ),
      // controller for get the Amount foreach Catogery timeDate
      CustomComboBox(
        width: 96,
        selectedTime: selectedTime,
        list: [AppString.all] + listFilterDate,
        onChanged: (String value) {
          setState(() {});
        },
      ),
      SizedBox(
        height: 200,
        width: 200,
        child: AnimatedCircularChart(
          edgeStyle: SegmentEdgeStyle.round,
          size: const Size(200, 200),
          initialChartData: <CircularStackEntry>[
            CircularStackEntry([
              CircularSegmentEntry(
                getDivDecimal(incomAmount, incomAmount + expanseAmount),
                ColorManager.green,
              ),
              CircularSegmentEntry(
                getDivDecimal(expanseAmount, incomAmount + expanseAmount),
                ColorManager.red,
              )
            ]),
          ],
          chartType: CircularChartType.Radial,
          holeLabel: "${AppString.tl} ${incomAmount - expanseAmount}",
          labelStyle: TextStyle(
            color: Colors.blueGrey[600],
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      //list of catogery expanse or incom amount
      ValueListenableBuilder(
        valueListenable: _isIncome,
        builder: (context, value, child) => Column(
          children: [
            Container(
              width: 351,
              height: 59,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(59),
              ),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    _isIncome.value = false; //clicked on  expanse conatiner
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 171,
                    decoration: BoxDecoration(
                      color: value ? null : ColorManager.red,
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Text(
                      AppString.expenses,
                      style: TextStyle(
                        color: value ? ColorManager.black : ColorManager.white,
                        fontSize: 16,
                        fontFamily: INTER_FONT,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    _isIncome.value = true; //clicked on income conatiner
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    width: 171,
                    decoration: BoxDecoration(
                      color: value ? ColorManager.green : null,
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Text(
                      AppString.income,
                      style: TextStyle(
                        color: value ? ColorManager.white : ColorManager.black,
                        fontSize: 16,
                        fontFamily: INTER_FONT,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            //if value is false will get list of catogery
            //if value is true will get the income amount
            value
                ? getItemProgras(
                    AppString.incomeRate,
                    FilterList.getTheIncomAmountMonth(list),
                    ColorManager.green,
                    100000) //10000 the current amount in mounth
                : SizedBox(
                    height: 250,
                    child: ListView(
                      children: [
                        getItemProgras(
                            AppString.food,
                            FilterList.getAmountByCatogery(
                                AppString.food, list, selectedTime.value),
                            ColorManager.yellow,
                            expanseAmount),
                        getItemProgras(
                            AppString.internet,
                            FilterList.getAmountByCatogery(
                                AppString.internet, list, selectedTime.value),
                            ColorManager.green,
                            expanseAmount),
                        getItemProgras(
                            AppString.subscription,
                            FilterList.getAmountByCatogery(
                                AppString.subscription,
                                list,
                                selectedTime.value),
                            ColorManager.foucosedColor,
                            expanseAmount),
                        getItemProgras(
                            AppString.gifts,
                            FilterList.getAmountByCatogery(
                                AppString.gifts, list, selectedTime.value),
                            ColorManager.foucosedColor,
                            expanseAmount),
                        getItemProgras(
                            AppString.shopping,
                            FilterList.getAmountByCatogery(
                                AppString.shopping, list, selectedTime.value),
                            ColorManager.foucosedColor,
                            expanseAmount),
                      ],
                    ))
          ],
        ),
      )
    ]));
  }

  Widget getItemProgras(String name, int value, Color color, int amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 164,
                child: Row(
                  children: [
                    Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(14))),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                        fontFamily: INTER_FONT,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                  name == AppString.incomeRate ? amount.toString() : "- $value",
                  style: TextStyle(
                    color: name == AppString.incomeRate
                        ? ColorManager.green
                        : ColorManager.red,
                    fontSize: 24,
                    fontFamily: INTER_FONT,
                    fontWeight: FontWeight.w500,
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          LinearProgressIndicator(
            minHeight: 8,
            value: amount == 0 ? 0 : value / amount,
            color: color,
            backgroundColor: ColorManager.nonFoucosedColor,
          )
        ],
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
          AppString.financialReport,
          style: TextStyle(
            fontFamily: INTER_FONT,
            fontWeight: FontWeight.w600,
            color: ColorManager.black,
            fontSize: 18,
          ),
        ));
  }

  double getDivDecimal(int i, int j) {
    return (i * 100) / j;
  }
}
