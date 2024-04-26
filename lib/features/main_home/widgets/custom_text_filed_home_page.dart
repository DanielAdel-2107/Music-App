import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/core/resources/font_managers.dart';
import 'package:music_apps/core/resources/padding_value.dart';
import 'package:music_apps/core/resources/radius_values_managers.dart';
import 'package:music_apps/core/resources/strings_values_managers.dart';

class CustomTextFieldHomePage extends StatelessWidget {
  const CustomTextFieldHomePage({
    super.key,
    required this.onTap,
    this.isSearchNow = false,
    required this.onTapCloseIcon, required this.streamCloseStatus, required this.onSubmitted,
  });

  final GestureTapCallback onTap;
  final GestureTapCallback onTapCloseIcon;
  final bool isSearchNow;
  final Stream  streamCloseStatus;

  final ValueChanged<String> onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: PaddingValue.p51,
          right: PaddingValue.p31,
          left: PaddingValue.p31),
      child: StreamBuilder(
        stream: streamCloseStatus,
        builder: (context, snapshot) => TextField(
          onSubmitted:onSubmitted ,
          // onChanged: ,
          onTap: onTap,
          decoration: InputDecoration(
            suffixIcon: snapshot.data == true
                ? InkWell(onTap: onTapCloseIcon, child: const Icon(Icons.clear))
                : null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: PaddingValue.p10),
            hintText: StringsValuesManagers.searchSong,
            hintStyle: const TextStyle(
                color: ColorManagers.kWhiteColor,
                fontSize: FontSizeManagers.f12),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(
                  left: PaddingValue.p20, right: PaddingValue.p10),
              child: Icon(
                Icons.search,
                color: ColorManagers.kWhiteColor,
              ),
            ),
            filled: true,
            fillColor: ColorManagers.kLightWhiteColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RadiusValuesManager.r50)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RadiusValuesManager.r50)),
          ),
        ),
      ),
    );
  }
}
