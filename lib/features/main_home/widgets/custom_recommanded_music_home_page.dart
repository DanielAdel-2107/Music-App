import 'package:flutter/material.dart';
import 'package:music_apps/models/songsModel.dart';

import 'custom_row_recommanded_music.dart';

class CustomRecommandedMusicHome extends StatelessWidget {
  const CustomRecommandedMusicHome(
      {super.key, required this.onTap, required this.listSongModel});

  final Function(int index) onTap;
  final List<SongsModel> listSongModel;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                onTap(index);
              },
              child: CustomRowRecommendedMusic(
                songsModel: listSongModel[index],
              )),
          itemCount: listSongModel.length),
    );
  }
}

