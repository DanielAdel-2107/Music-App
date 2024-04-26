import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

import '../core/resources/constants_value.dart';

class PlayMusicController {
  late int index;
  late AudioPlayer audioPlayer;
  late AudioCache audioCache;
  late StreamController<bool> playStatusStreamController;
  late Sink<bool> playStatusInputData;
  late Stream<bool> playStatusOutputData;
  late StreamController<Duration> durationNowStreamController;
  late Sink<Duration> durationNowInputData;
  late Stream<String> durationNowOutputData;
  late StreamController<Duration> sliderValueStreamController;
  late Sink<Duration> sliderValueInputData;
  late Stream<double> sliderValueOutputData;
  late StreamController<int> detailsStreamController;
  late Sink<int> detailsInputData;
  late Stream<int> detailsOutputData;
  late StreamController<bool> loopStatusStreamController;
  late Sink<bool> loopStatusInputData;
  late Stream<bool> loopStatusOutputData;
  late Uri uri;
  bool isPlaying = true;
  double valueSlider = 0;
  bool loopStatus = false;

  // constructor private
  // instance
  // default constructor
  PlayMusicController._internal(this.index) {
    audioCache = AudioCache(prefix: "");
    audioPlayer = AudioPlayer();
    playStatusStreamController = StreamController();
    playStatusInputData = playStatusStreamController.sink;
    playStatusOutputData =
        playStatusStreamController.stream.asBroadcastStream();
    loopStatusStreamController = StreamController();
    loopStatusInputData = loopStatusStreamController.sink;
    loopStatusOutputData =
        loopStatusStreamController.stream.asBroadcastStream();
    detailsStreamController = StreamController();
    detailsInputData = detailsStreamController.sink;
    detailsOutputData = detailsStreamController.stream.asBroadcastStream();
    sliderValueStreamController = StreamController();
    sliderValueInputData = sliderValueStreamController.sink;
    sliderValueOutputData = sliderValueStreamController.stream
        .asBroadcastStream()
        .map((event) => transferDurationToValueSlider(event));
    sliderValueOutputData = sliderValueStreamController.stream
        .asBroadcastStream()
        .map((event) => transferDurationToValueSlider(event));

    durationNowStreamController = StreamController();
    durationNowInputData = durationNowStreamController.sink;
    durationNowOutputData = durationNowStreamController.stream
        .map((event) => transferDurationToMinuteAndSecond(event));
    durationNowOutputData = durationNowStreamController.stream
        .asBroadcastStream()
        .map((event) => transferDurationToMinuteAndSecond(event));
  }

  static PlayMusicController? instance;

  factory PlayMusicController(int index) {
    if (instance != null) instance!.index = index;
    instance ??= PlayMusicController._internal(index);
    return instance!;
  }

  Duration? audioTime;

  double transferDurationToValueSlider(Duration duration) {
    double durationNowInsecond = duration.inSeconds.toDouble();
    double maxTime = audioTime!.inSeconds.toDouble();
    valueSlider = (durationNowInsecond / maxTime) * 1.0;
    valueSlider = valueSlider > 1 ? 1 : valueSlider;
    return valueSlider;
  }

  void onChangedThumbSlider(double value) {
    Duration duration = transferValueSliderToDuration(value);
    audioPlayer.seek(duration);
  }

  void onNextTap() {
    if (index < ConstantsValue.listQuarn.length - 1) {
      index++;
    } else {
      index = 0;
    }
    play();
  }

  void onBackTap() {
    if (index == 0) {
      index = ConstantsValue.listQuarn.length - 1;
    } else {
      index--;
    }
    play();
  }

  void onTapLoop() {
    if (audioPlayer.releaseMode == ReleaseMode.loop) {
      audioPlayer.setReleaseMode(ReleaseMode.release);
      loopStatus = false;
    } else {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      loopStatus = true;
    }
    loopStatusInputData.add(loopStatus);
  }

  Duration transferValueSliderToDuration(double sliderValue) {
    double valueNow = (sliderValue / 1.0) * audioTime!.inSeconds.toDouble();

    return Duration(seconds: valueNow.toInt());
  }

  Future<Duration?> play() async {
    uri = await audioCache.load(ConstantsValue.listQuarn[index!].pathSong);

    await audioPlayer.play(UrlSource(uri.toString()));
    audioTime = await audioPlayer.getDuration();
    detailsInputData.add(index);
    print(index);
    audioPlayer.onPositionChanged.listen((event) {
      playStatusInputData.add(isPlaying);
      durationNowInputData.add(event);
      sliderValueInputData.add(event);
    });
    audioPlayer.onPlayerComplete.listen((event) {
      print("done");
      onNextTap();
    });
    print(audioTime);
    isPlaying = true;

    return audioTime;
  }

  Future<String> myDuration() async {
    await Future.delayed(Duration(seconds: 4));

    return "hello";
  }

  void changePlayStatus() {
    if (audioPlayer.state == PlayerState.playing) {
      audioPlayer.pause();
      isPlaying = false;
    } else if (audioPlayer.state == PlayerState.paused) {
      audioPlayer.resume();
      isPlaying = true;
    }
    playStatusInputData.add(isPlaying);
  }

  void disposeAudio() {
    playStatusInputData.close();
    playStatusStreamController.close();
    // audioPlayer.dispose();
  }

  String transferDurationToMinuteAndSecond(Duration? duration) {
    String minute =
        duration!.inMinutes.remainder(60).toString().padLeft(2, '0');
    String second =
        duration!.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${minute}:${second} ';
  }

  void onTapRandom() {
    int i = Random().nextInt(ConstantsValue.listQuarn.length);
    if (i == index) i = Random().nextInt(ConstantsValue.listQuarn.length);
    index = i;
    play();
  }
}
