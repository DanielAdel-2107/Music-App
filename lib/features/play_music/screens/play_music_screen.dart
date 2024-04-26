import 'package:flutter/material.dart';
import 'package:music_apps/controller/home_page_controller.dart';
import 'package:music_apps/controller/play_music_controller.dart';
import 'package:music_apps/core/resources/alignment_managers.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/core/resources/constants_value.dart';
import 'package:music_apps/core/resources/height_values_managers.dart';
import 'package:music_apps/features/play_music/widgets/cusotm_button_controller_play_music.dart';
import 'package:music_apps/features/play_music/widgets/custom_app_bar_play_music_screen.dart';
import 'package:music_apps/features/play_music/widgets/custom_tool_play_music.dart';
import '../widgets/custom_songs_details_play_music_screen.dart';
import '../widgets/custom_tool_2_play_music.dart';

class PlayMusicScreen extends StatefulWidget {
  const PlayMusicScreen({super.key});

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late int index;
  late PlayMusicController _playMusicController;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    index = ModalRoute.of(context)!.settings.arguments as int;
    _playMusicController = PlayMusicController(index);
  }

  @override
  void dispose() {
    // _playMusicController.disposeAudio();
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBarPlayMusicScreen(
          onPressed: () {
            HomePageController.navigatorToPop(context: context);
          },
        ),
        body: FutureBuilder(
          future: _playMusicController.play(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(AlignmentManagersX.x0_20,
                            AlignmentManagersY.y_0_98),
                        end: Alignment(AlignmentManagersX.x_0_20,
                            AlignmentManagersY.y0_98),
                        colors: [
                      ColorManagers.kPrimaryColor,
                      ColorManagers.kDarkBlueColor
                    ])),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        StreamBuilder<int>(
                          stream: _playMusicController.detailsOutputData,
                          builder: (context, snapshot) =>
                              CustomSongsDetailsPlayMusic(
                            songsModel: ConstantsValue
                                .listQuarn[snapshot.data ?? index],
                          ),
                        ),
                        const SizedBox(
                          height: HeightValuesManagers.h29,
                        ),
                        CustomButtonControllerPlayMusic(
                          onTapRandom: () {
                            _playMusicController.onTapRandom();
                          },
                          onTapLoop: () {
                            _playMusicController.onTapLoop();
                          },
                          loopStatusOutputData:
                              _playMusicController.loopStatusOutputData,
                          onTapBack: () {
                            _playMusicController.onBackTap();
                          },
                          onTapNext: () {
                            _playMusicController.onNextTap();
                          },
                          onChangedSlider: (value) {
                            _playMusicController.onChangedThumbSlider(value);
                          },
                          sliderValueOutputData:
                              _playMusicController.sliderValueOutputData,
                          durationNowOutputData:
                              _playMusicController.durationNowOutputData,
                          audioTime: _playMusicController
                              .transferDurationToMinuteAndSecond(snapshot.data),
                          playStatusOutputData:
                              _playMusicController.playStatusOutputData,
                          onStop: () {
                            _playMusicController.changePlayStatus();
                          },
                        ),
                        const CustomToolsPlayMusic(),
                        const CustomTools2PlayMusic()
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text('error');
            }
          },
        ));
  }
}
