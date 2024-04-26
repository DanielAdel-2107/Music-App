import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_apps/core/resources/assets_managers.dart';
import 'package:music_apps/core/resources/color_managers.dart';
import 'package:music_apps/core/resources/font_managers.dart';
import 'package:music_apps/core/resources/height_values_managers.dart';
import 'package:music_apps/core/resources/radius_values_managers.dart';
import 'package:music_apps/core/resources/width_values_managers.dart';

class CustomButtonControllerPlayMusic extends StatelessWidget {
  const CustomButtonControllerPlayMusic({
    super.key,
    required this.onStop,
    required this.playStatusOutputData,
    required this.audioTime,
    required this.durationNowOutputData,
    required this.sliderValueOutputData,
    required this.onChangedSlider,
    required this.onTapNext,
    required this.onTapBack,
    required this.loopStatusOutputData,
    required this.onTapLoop, required this.onTapRandom,
  });

  final GestureTapCallback onStop;
  final Stream playStatusOutputData;
  final Stream<String> durationNowOutputData;
  final Stream<double> sliderValueOutputData;
  final Stream<bool> loopStatusOutputData;
  final String audioTime;
  final ValueChanged<double> onChangedSlider;
  final GestureTapCallback onTapNext;
  final GestureTapCallback onTapBack;
  final GestureTapCallback onTapLoop;
  final GestureTapCallback onTapRandom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: onTapRandom,
                child: Image(image: AssetImage(AssetsManagers.random))),
            Container(
                width: WidthValuesManagers.w36,
                height: HeightValuesManagers.h36,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(RadiusValuesManager.r50),
                    gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [
                          ColorManagers.kThirdPrimaryColor,
                          ColorManagers.kLightWhiteColor,
                        ])),
                child: InkWell(
                  onTap: onTapBack,
                  child: const Image(
                      height: HeightValuesManagers.h20,
                      width: WidthValuesManagers.w20,
                      image: AssetImage(AssetsManagers.back)),
                )),
            InkWell(
              onTap: onStop,
              child: StreamBuilder(
                stream: playStatusOutputData,
                builder: (context, snapshot) => CircleAvatar(
                  radius: RadiusValuesManager.r30,
                  backgroundColor: ColorManagers.kLightWhiteColor,
                  child: Image(
                      width: 30,
                      height: 30,
                      image: AssetImage(snapshot.data == true
                          ? AssetsManagers.pause
                          : AssetsManagers.play)),
                ),
              ),
            ),
            Container(
                width: HeightValuesManagers.h36,
                height: WidthValuesManagers.w36,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(RadiusValuesManager.r50),
                    gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [
                          ColorManagers.kThirdPrimaryColor,
                          ColorManagers.kLightWhiteColor,
                        ])),
                child: InkWell(
                  onTap: onTapNext,
                  child: const Image(
                      width: WidthValuesManagers.w20,
                      height: WidthValuesManagers.w20,
                      image: AssetImage(AssetsManagers.next)),
                )),
            InkWell(
              onTap: onTapLoop,
              child: StreamBuilder(
                stream: loopStatusOutputData,
                builder: (context, snapshot) => Image(
                    width: 30,
                    height: 30,
                    image: AssetImage(snapshot.data == null
                        ? AssetsManagers.loopUnActive
                        : AssetsManagers.loopActive)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: HeightValuesManagers.h29,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SliderTheme(
              data: SliderThemeData(
                  // thumbShape: RoundSliderThumbShape(),
                  overlayShape: SliderComponentShape.noOverlay),
              child: StreamBuilder<double>(
                stream: sliderValueOutputData,
                builder: (context, snapshot) => Slider(
                  value: snapshot.data == null ? 0 : snapshot.data!.toDouble(),
                  onChanged: onChangedSlider,
                  activeColor: ColorManagers.kLightWhiteColor,
                  inactiveColor: const Color(0xff2F5D9A),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<String>(
                stream: durationNowOutputData,
                builder: (context, snapshot) => Text(
                  snapshot.data.toString(),
                  style: const TextStyle(
                      color: ColorManagers.kLightWhiteColor,
                      fontSize: FontSizeManagers.f12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                audioTime,
                style: const TextStyle(
                    color: ColorManagers.kLightWhiteColor,
                    fontSize: FontSizeManagers.f12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RoundSliderThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0.0, 0.0); // Adjust the size of the thumb
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = ColorManagers.kLightWhiteColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, 3.0, paint); // Draw a circle as the thumb

    // TODO: implement paint
  }
}
