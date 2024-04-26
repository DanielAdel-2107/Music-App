import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_apps/controller/home_page_controller.dart';
import 'package:music_apps/core/resources/alignment_managers.dart';
import 'package:music_apps/core/resources/assets_managers.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/core/resources/constants_value.dart';
import 'package:music_apps/core/resources/font_managers.dart';
import 'package:music_apps/core/resources/height_values_managers.dart';
import 'package:music_apps/core/resources/routes_managers.dart';
import 'package:music_apps/core/resources/strings_values_managers.dart';
import 'package:music_apps/features/main_home/widgets/custom_recommanded_music_home_page.dart';
import 'package:music_apps/features/main_home/widgets/custom_row_recommanded_music.dart';
import 'package:music_apps/features/main_home/widgets/custom_search_details.dart';
import 'package:music_apps/features/main_home/widgets/custom_text_filed_home_page.dart';
import 'package:music_apps/features/main_home/widgets/custom_title_home_page.dart';
import 'package:music_apps/models/songsModel.dart';

import '../widgets/custom_search_feature.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageController = HomePageController();
  }

  @override
  void dispose() {
    homePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(
                  AlignmentManagersX.x0_20, AlignmentManagersY.y_0_98),
              end: Alignment(
                  AlignmentManagersX.x_0_20, AlignmentManagersY.y0_98),
              colors: [
            ColorManagers.kPrimaryColor,
            ColorManagers.kDarkBlueColor
          ])),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFieldHomePage(
              onSubmitted: (value) {
                homePageController.searchAboutSong(value);
              },
              streamCloseStatus: homePageController.closeStatusSearchOutputData,
              onTapCloseIcon: () {
                homePageController.onTapOutsideSearchTextField();
              },
              isSearchNow: homePageController.tappedOnSearchTextField,
              onTap: () {
                homePageController.onTapSearchTextField();
              },
            ),
            StreamBuilder(
                stream: homePageController.tappedStatusSearchOutputData,
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data == false) {
                    return const SizedBox();
                  } else {
                    return CustomSearchFeature(
                     listSearchOutputData: homePageController.listSearchOutputDataOutputData,
                    );
                  }
                }),
            const CustomTitleHomePage(
              title: "Recommanded music",
            ),
            const SizedBox(
              height: HeightValuesManagers.h22,
            ),
            CustomRecommandedMusicHome(
              listSongModel: ConstantsValue.listQuarn,
              onTap: (index) {
                HomePageController.navigatorToPlayMusicScreen(
                    context: context, index: index);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
