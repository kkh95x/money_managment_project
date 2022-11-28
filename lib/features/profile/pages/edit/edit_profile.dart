import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_managment_app/features/widgets/app_widget.dart';
import 'package:money_managment_app/features/profile/controller/profile_provider.dart';

import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String newUsername = "";

  String newImagePath = "";

  @override
  Widget build(BuildContext context) {
    // print("Edit Profile build");
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
        backgroundColor: ColorManager.color1HeaderContainerHomePage,
        appBar: getAppar(onPressed: () {
          Navigator.of(context).pop();
        }),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      newImagePath == ""
                          ? const CircleAvatarUser()
                          : Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  image: DecorationImage(
                                      image: FileImage(File(newImagePath)),
                                      fit: BoxFit.cover)),
                            ),
                      Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorManager.foucosedColor,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                newImagePath = image.path; //get image path
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.camera,
                              size: 30,
                            )),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                          newUsername = value;
                        },
                        style: TextStyle(
                          color: ColorManager.headerTextColorLight,
                          fontSize: 16,
                          fontFamily: INTER_FONT,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: AppString.username,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    color: ColorManager.foucosedColor,
                    name: AppString.continue1,
                    textColor: ColorManager.white,
                    onTap: (() {
                      if (newUsername == "" && newImagePath == "") {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(actions: [
                            Center(
                                child: Text(AppString.showAlterDialogIsEmpty))
                          ]),
                        );
                      } else {
                        if (newUsername != "") {
                          //user choose newUsername

                          profileProvider.setUsername = newUsername;
                        }
                        if (newImagePath != "") {
                          //user choose new image
                          profileProvider.setNewImagePathProfile = newImagePath;
                        }
                        Navigator.of(context).pop();
                      }
                    }),
                  )
                ]))));
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
          AppString.editProfile,
          style: TextStyle(
            fontFamily: INTER_FONT,
            fontWeight: FontWeight.w600,
            color: ColorManager.black,
            fontSize: 18,
          ),
        ));
  }
}
