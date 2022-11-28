import 'package:flutter/material.dart';
import 'package:money_managment_app/features/main_app/main.app.dart';

import 'package:money_managment_app/features/money/controller/money_provider.dart';
import 'package:money_managment_app/features/money/pages/add/add_trans.dart';
import 'package:money_managment_app/features/profile/controller/profile_provider.dart';
import 'package:money_managment_app/features/profile/pages/edit/edit_profile.dart';
import 'package:money_managment_app/features/splash/welcom_view.dart';
import 'package:provider/provider.dart';

import 'core/strings_manager.dart';

/*


Explanation video link:
https://drive.google.com/file/d/1sgyXvkjf9mHCJSdBXGU25HlRWSYQ3Gpi/view?usp=share_link



*/
void main() {
  runApp(MultiProvider(
    providers: [
      ListenableProvider<MoneyProvider>(
          create: (BuildContext context) => MoneyProvider()),
      ListenableProvider<ProfileProvider>(
          create: (BuildContext context) => ProfileProvider()),
    ],
    child: MaterialApp(
      routes: {
        RouteManager.welcomePageRoute: (context) => const WelcomeView(),
        RouteManager.homePageRoute: (context) => const MainAppView(),
        RouteManager.addPageRoute: (context) => AddTransView(),
        RouteManager.editProfile: (context) => const EditProfile()
      },
      initialRoute: RouteManager.welcomePageRoute,
    ),
  ));
}
