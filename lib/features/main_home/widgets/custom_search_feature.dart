import 'package:flutter/material.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/models/songsModel.dart';

import '../../../controller/home_page_controller.dart';
import '../../../core/resources/constants_value.dart';
import '../../../core/resources/height_values_managers.dart';
import '../../../core/resources/strings_values_managers.dart';
import 'custom_search_details.dart';
import 'custom_title_home_page.dart';

class CustomSearchFeature extends StatelessWidget {
  const CustomSearchFeature({
    super.key,
    required this.listSearchOutputData,
  });

  final Stream<List<SongsModel>> listSearchOutputData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTitleHomePage(
          title: StringsValuesManagers.searchSong,
        ),
        const SizedBox(
          height: HeightValuesManagers.h22,
        ),
        StreamBuilder(
          stream: listSearchOutputData,
          builder: (context, snapshot) =>
              snapshot.data == null||snapshot.data!.length == 0
                  ? Text(
                      "No found",
                      style: TextStyle(color: ColorManagers.kWhiteColor),
                    )
                  : CustomSearchDetails(
                      onTap: (index) {
                        HomePageController.navigatorToPlayMusicScreen(
                            context: context, index: index);
                      },
                      itemCount: snapshot.data!.length,
                      listSongsModel: snapshot.data!,
                    ),
        )
      ],
    );
  }
}
