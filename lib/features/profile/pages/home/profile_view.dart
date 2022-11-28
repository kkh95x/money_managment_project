import 'package:flutter/material.dart';
import 'package:money_managment_app/features/widgets/app_widget.dart';
import 'package:money_managment_app/features/money/widgets/global_widgets.dart';
import 'package:money_managment_app/features/profile/controller/profile_provider.dart';
import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 118),
        child: Column(children: [
          Consumer<ProfileProvider>(
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatarUser(
                    hight: 80,
                    width: 80,
                  ),
                  Column(
                    children: [
                      Text(
                        AppString.username,
                        style: TextStyle(
                            fontFamily: INTER_FONT,
                            color: ColorManager.nonFoucosedColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        value.getUsername,
                        style: TextStyle(
                            fontFamily: INTER_FONT,
                            color: ColorManager.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteManager.editProfile);
                      },
                      icon: const Icon(Icons.edit)),
                ],
              );
            },
          ),
          const SizedBox(
            height: 62,
          ),
          SizedBox(
            height: 394,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Container(
                    alignment: Alignment.center,
                    height: 89,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: ColorManager.white),
                    child: getItemMenu(
                      AppString.account,
                      Icon(
                        Icons.wallet,
                        color: ColorManager.foucosedColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 89,
                  color: ColorManager.white,
                  child: getItemMenu(
                      AppString.settings,
                      Icon(
                        Icons.settings,
                        color: ColorManager.foucosedColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Container(
                    alignment: Alignment.center,
                    height: 89,
                    color: ColorManager.white,
                    child: getItemMenu(
                        AppString.exportData,
                        Icon(
                          Icons.share,
                          color: ColorManager.foucosedColor,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Container(
                    alignment: Alignment.center,
                    height: 89,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        color: ColorManager.white),
                    child: getItemMenu(
                        AppString.logout,
                        Icon(
                          Icons.exit_to_app,
                          color: ColorManager.red,
                        )),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget getItemMenu(String txt, Icon icon) {
    return ListTile(
      title: Text(
        txt,
        style: TextStyle(
            fontFamily: INTER_FONT,
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: txt == AppString.logout
                  ? ColorManager.red.withOpacity(0.3)
                  : ColorManager.packgroundIconMenu),
          child: icon),
    );
  }
}
