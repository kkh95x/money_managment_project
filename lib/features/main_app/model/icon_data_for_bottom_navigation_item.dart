// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:money_managment_app/core/strings_manager.dart';

List<IconBottomData> listIconsData = [
  IconBottomData(
    iconSelected: AppImagesPath.homeEnable,
    name: AppString.home,
    iconUnSelected: AppImagesPath.homeDisable,
  ),
  IconBottomData(
    iconSelected: AppImagesPath.tranEnable,
    name: AppString.transaction,
    iconUnSelected: AppImagesPath.tranDisable,
  ),
  IconBottomData(
    iconSelected: AppImagesPath.statiticsEnable,
    name: AppString.statitics,
    iconUnSelected: AppImagesPath.statiticsDisable,
  ),
  IconBottomData(
    iconSelected: AppImagesPath.personEnable,
    name: AppString.profile,
    iconUnSelected: AppImagesPath.personDisable,
  ),
];

class IconBottomData {
  String iconSelected;
  String iconUnSelected;
  String name;
  IconBottomData({
    required this.iconSelected,
    required this.iconUnSelected,
    required this.name,
  });
}
