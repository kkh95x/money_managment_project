import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_managment_app/core/filter_list.dart';
import 'package:money_managment_app/features/widgets/app_widget.dart';
import 'package:money_managment_app/features/money/controller/money_provider.dart';
import 'package:money_managment_app/features/money/model/record_money_model.dart';
import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //print("Build Home Page");
    List<RecordMoneyModel> list =
        Provider.of<MoneyProvider>(context).getListMoney;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              /*
              Header Container Information
              */
              getHeaderContainer(
                size,
                Provider.of<MoneyProvider>(context, listen: false).getTodayDate,
                FilterList.getTheTotalAmount(list).toString(), //total Amount
                FilterList.getTheIncomAmount(list).toString(), //income Amount
                FilterList.getTheExpancAmount(list).toString(), //Expanse Amount
              ),
              const SizedBox(
                height: 15,
              ),

              /*

              List Filter [Tody,week,month,year] Widget
              
               */

              // list with background container black border
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          border: Border.all(
                            width: 2,
                            color: ColorManager.white,
                          )),
                    ),
                  ),

                  /*
                   List Filter Widget
                 */
                  const ListFilter(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              /*
      
            Recent Transaction     ViewAll
      
      
            */
              getRowRecentViewAll(
                () {
                  //goto transaction page
                  Provider.of<MoneyProvider>(context).setPageIndex = 1;
                },
              ),

              /*
      
            List items last 3 Recnet Transation
      
            */
              Container(
                height: 250,
                padding: const EdgeInsets.only(top: 15),
                child: const ListRecentTransaction(),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*



 Methoud  Local Widget



*/
  Widget getRowRecentViewAll(void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppString.recentTransaction,
              style: TextStyle(
                color: ColorManager.black,
                fontFamily: INTER_FONT,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
          InkWell(
            onTap: () {
              onTap();
            },
            child: Text(AppString.viewAll,
                style: TextStyle(
                  color: ColorManager.black,
                  fontFamily: INTER_FONT,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
          )
        ],
      ),
    );
  }

  Widget getHeaderContainer(Size size, String dataDayTime, String totalAmount,
      String income, String expemse) {
    return Container(
      width: size.width,
      height: 361,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        gradient: LinearGradient(
          colors: [
            ColorManager.color1HeaderContainerHomePage,
            ColorManager.color2HeaderContainerHomePage,
          ],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          //header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Date time
                SizedBox(
                  height: 34,
                  child: Text(
                    dataDayTime,
                    style: TextStyle(
                      color: ColorManager.headerTextColor,
                      fontFamily: INTER_FONT,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.4,
                  height: 80,
                ),
                //profile pic and name
                SizedBox(
                  width: 103,
                  child: Row(
                    children: const [
                      CircleAvatarUser(
                        hight: 35,
                        width: 35,
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      UserNameText(
                        textsize: 14,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
            color: ColorManager.headerTextColor,
          ),
          const SizedBox(
            height: 51,
          ),
          Text(
            AppString.accountBslance,
            style: TextStyle(
              color: ColorManager.headerTextColorLight,
              fontFamily: INTER_FONT,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.01 * size.height),
          /*
      
                  Amount Headr Text
      
                  */
          Text(
            totalAmount,
            style: TextStyle(
              color: ColorManager.headerTextAmount,
              fontFamily: INTER_FONT,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          /* 
      
            Income money and Expans money Widget
      
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getInputAndOutputIconsAmount(
                amount: income,
                color: ColorManager.green,
                imagepath: AppImagesPath.inIcon,
                type: AppString.income,
              ),
              getInputAndOutputIconsAmount(
                amount: expemse,
                color: ColorManager.red,
                imagepath: AppImagesPath.outIcon,
                type: AppString.expenses,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getInputAndOutputIconsAmount(
      {required String imagepath,
      required Color color,
      required String type,
      required String amount}) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      width: 164,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            imagepath,
            width: 48,
            height: 48,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  color: ColorManager.white,
                  fontFamily: INTER_FONT,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                amount,
                style: TextStyle(
                  color: ColorManager.white,
                  fontFamily: INTER_FONT,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// List Filter

class ListFilter extends StatelessWidget {
  const ListFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MoneyProvider>(
      builder: (BuildContext context, MoneyProvider value, Widget? child) {
        // print("Build  The List Filter [tody,week,.....]");

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getListFilterWidget(
                value.indexFilterOnHomePage,
                size,
                (index) {
                  value.setIndexFilterOnHomePage = index;
                },
              ),
            ));
      },
    );
  }

  Widget getFilterWidgetFoucosed(
      {required double width, required String name}) {
    return Container(
      height: 34,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: ColorManager.headerTextAmount,
      ),
      child: Text(
        name,
        style: TextStyle(
          color: ColorManager.white,
          fontFamily: INTER_FONT,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget getFilterWidgetNoFoucosed(
      {required double width,
      required String name,
      required void Function() onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 34,
        width: width,
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            color: ColorManager.white,
            fontFamily: INTER_FONT,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

//create List of filter
  List<Widget> getListFilterWidget(
      int curentIndex, Size size, void Function(int) onTap) {
    return [
      for (int i = 0; i < listFilterDate.length; i++)
        if (i == curentIndex)
          getFilterWidgetFoucosed(
              name: listFilterDate[i], width: 0.19 * size.width)
        else
          getFilterWidgetNoFoucosed(
              width: 0.2 * size.width,
              name: listFilterDate[i],
              onTap: () {
                onTap(i);
              })
    ];
  }
}

class ListRecentTransaction extends StatelessWidget {
  const ListRecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return Container(
                color: value.getListMoney[index].isIncomeMoney
                    ? ColorManager.colorItemsRecent.withOpacity(0.5)
                    : ColorManager.colorItemsRecent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: ListTile(
                    leading: Container(
                      width: 38,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: value.getListMoney[index].isIncomeMoney
                              ? ColorManager.green
                              : ColorManager.red),
                      child: Icon(
                        value.getListMoney[index].isIncomeMoney
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        size: 23,
                        color: ColorManager.white,
                      ),
                    ),
                    title: Text(
                      "TL ${value.getListMoney[index].money}",
                      style: TextStyle(
                        color: ColorManager.black,
                        fontFamily: INTER_FONT,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Text(
                      value.getListMoney[index].category,
                      style: TextStyle(
                        color: ColorManager.catogryitemsRecent,
                        fontFamily: INTER_FONT,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ));
          }),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 18,
            );
          },
          itemCount:
              value.getListMoney.length <= 3 ? value.getListMoney.length : 3,
        ),
      );
    });
  }
}
