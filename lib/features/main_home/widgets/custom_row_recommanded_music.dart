import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/core/resources/font_managers.dart';
import 'package:music_apps/models/songsModel.dart';

class CustomRowRecommendedMusic extends StatelessWidget {
  const CustomRowRecommendedMusic({
    super.key, required this.songsModel,
  });
 final SongsModel songsModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        songsModel.song,
        style: const TextStyle(
          fontSize: FontSizeManagers.f15,
          color: ColorManagers.kWhiteColor,
        ),
      ),
      subtitle: Text(
        songsModel.singer,
        style: const TextStyle(
            color: ColorManagers.kLightWhiteColor,
            fontSize: FontSizeManagers.f12),
      ),
      leading:   CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage(
          songsModel.image,
        ),
      ),
      trailing: const Icon(CupertinoIcons.heart),
    );
  }
}
