// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:money_managment_app/features/profile/controller/profile_provider.dart';

class CircleAvatarUser extends StatelessWidget {
  final double width;
  final double hight;
  const CircleAvatarUser({
    Key? key,
    this.width = 2000,
    this.hight = 200,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return Container(
        width: width,
        height: hight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: ColorManager.foucosedColor, width: 3),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: getImgesProvider(
                profileProvider.isImageChanged,
                profileProvider.getDefaultImagePathProfile,
                profileProvider.getNewImagePathProfile),
          ),
        ));
  }

  ImageProvider getImgesProvider(bool isImageChanged,
      String getDefaultImagePathProfile, String getNewImagePathProfile) {
    if (isImageChanged) {
      return FileImage(File(getNewImagePathProfile));
    } else {
      return AssetImage(getDefaultImagePathProfile);
    }
  }
}

class UserNameText extends StatelessWidget {
  final double textsize;

  const UserNameText({
    Key? key,
    required this.textsize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return Text(
      profileProvider.getUsername,
      style: TextStyle(
        color: ColorManager.headerTextColor,
        fontFamily: INTER_FONT,
        fontSize: textsize,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Color color;
  final String name;
  final Color textColor;
  final void Function() onTap;
  const MyButton({
    Key? key,
    required this.color,
    required this.name,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 56,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontFamily: INTER_FONT,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
