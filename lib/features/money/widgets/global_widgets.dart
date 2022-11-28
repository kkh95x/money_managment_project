// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:money_managment_app/core/color_manager.dart';
import 'package:money_managment_app/core/strings_manager.dart';

class CustomComboBox extends StatelessWidget {
  final ValueNotifier<String> selectedTime;
  final List list;
  final double width;
  final void Function(String value) onChanged;
  const CustomComboBox({
    Key? key,
    required this.selectedTime,
    required this.list,
    required this.width,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
