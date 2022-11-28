import 'package:flutter/material.dart';
import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/widgets/app_widget.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Main image Welcome
            getWelcomeImage(
              width: size.width,
            ),
            // ( "Simlpe Solution .." ) Text Widget
            getSimlpeSolutionForYourBudgetText(),

            //  ( " Discraption Massege On Welcome" ) Text Widget

            getdiscraptionMassegeOnWelcome(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: MyButton(
                color: ColorManager.black,
                name: AppString.continue1,
                textColor: ColorManager.white,
                onTap: () {
                  Navigator.of(context)
                      .popAndPushNamed(RouteManager.homePageRoute);
                },
              ),
            )

            // End Page
          ],
        ),
      ),
    );
  }

  Widget getWelcomeImage({required double width}) {
    return Container(
      width: width,
      height: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              AppImagesPath.onbording,
            ),
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          )),
    );
  }

  Widget getSimlpeSolutionForYourBudgetText() {
    return const Padding(
      padding: EdgeInsets.only(right: 37, left: 40, top: 167),
      child: Text(
        AppString.simlpeSolutionForYourBudgetTxt,
        style: TextStyle(
          fontFamily: INTER_FONT,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget getdiscraptionMassegeOnWelcome() {
    return const Padding(
      padding: EdgeInsets.only(left: 32, right: 60, top: 40),
      child: Text(
        AppString.counterAndDistributeTheIncomeCorrectlyTxt,
        style: TextStyle(
          fontFamily: INTER_FONT,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
