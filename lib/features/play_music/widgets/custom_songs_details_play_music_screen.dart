import 'package:flutter/material.dart';
import 'package:music_apps/core/resources/assets_managers.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/core/resources/font_managers.dart';
import 'package:music_apps/core/resources/height_values_managers.dart';
import 'package:music_apps/core/resources/radius_values_managers.dart';
import 'package:music_apps/models/songsModel.dart';

class CustomSongsDetailsPlayMusic extends StatelessWidget {
  const CustomSongsDetailsPlayMusic({
    super.key,
    required this.songsModel,
  });

  final SongsModel songsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(RadiusValuesManager.r10),
          child: Image(
            fit: BoxFit.cover,
            width: 261,
            height: 247,
            image: AssetImage(songsModel.image),
          ),
        ),
        const SizedBox(
          height: HeightValuesManagers.h11,
        ),
        Text(
          songsModel.song,
          style: const TextStyle(
              color: ColorManagers.kWhiteColor,
              fontSize: FontSizeManagers.f18,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: HeightValuesManagers.h4,
        ),
        Text(
          songsModel.singer,
          style: const TextStyle(
              color: ColorManagers.kLightWhiteColor,
              fontSize: FontSizeManagers.f12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
