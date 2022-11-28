import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:money_managment_app/features/main_app/model/icon_data_for_bottom_navigation_item.dart';
import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/money/controller/money_provider.dart';
import 'package:money_managment_app/features/money/pages/home/home_view.dart';
import 'package:money_managment_app/features/money/pages/statitics/statics_view.dart';
import 'package:money_managment_app/features/money/pages/transation/trans_view.dart';
import 'package:money_managment_app/features/profile/pages/home/profile_view.dart';
import 'package:provider/provider.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyProvider>(
        builder: (context, value, child) => Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              backgroundColor: value.getPageIndex == 0
                  ? ColorManager.backgrounColorPages
                  : ColorManager.color1HeaderContainerHomePage,
              floatingActionButton: FloatingActionButton(
                backgroundColor: ColorManager.foucosedColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.addPageRoute);
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
              bottomNavigationBar: getBottomNavigationBar(
                currentIndex: value.getPageIndex,
                onTap: (v) {
                  value.setPageIndex = v;
                },
              ),
              body: getNavigationHomePage(value.getPageIndex),
            ));
  }

  //get Page using index from Provider
  Widget getNavigationHomePage(int i) {
    switch (i) {
      case 0:
        return const HomeView();
      case 1:
        return const TransactionView();
      case 2:
        return const StaticsView();
      case 3:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }

  Widget getBottomNavigationBar(
      {required int currentIndex, required void Function(int) onTap}) {
    return BottomAppBar(
      notchMargin: 10,
      elevation: 6.0,
      shape: const CircularNotchedRectangle(),
      color: ColorManager.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //create 4 Bottom Items custom Icons
          const SizedBox(
            width: 4,
          ),
          InkWell(
            onTap: () {
              onTap(0);
            },
            child: getBottomNavigaionItem(0, 0 == currentIndex),
          ),

          InkWell(
              onTap: () {
                onTap(1);
              },
              child: getBottomNavigaionItem(1, 1 == currentIndex)),
          const SizedBox(
            width: 60,
          ),
          InkWell(
              onTap: () {
                onTap(2);
              },
              child: getBottomNavigaionItem(2, 2 == currentIndex)),
          InkWell(
              onTap: () {
                onTap(3);
              },
              child: getBottomNavigaionItem(3, 3 == currentIndex)),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }

  Widget getBottomNavigaionItem(
    int i,
    bool isSelected,
  ) {
    return SizedBox(
      height: 50,
      width: 60,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(isSelected
            ? listIconsData[i].iconSelected
            : listIconsData[i].iconUnSelected),
        Text(listIconsData[i].name,
            style: TextStyle(
                color: isSelected
                    ? ColorManager.foucosedColor
                    : ColorManager.nonFoucosedColor,
                fontFamily: INTER_FONT,
                fontSize: 9)),
      ]),
    );
  }
}
