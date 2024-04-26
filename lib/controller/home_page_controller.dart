import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_apps/core/resources/constants_value.dart';
import 'package:music_apps/core/resources/routes_managers.dart';
import 'package:music_apps/models/songsModel.dart';

class HomePageController {
  bool tappedOnSearchTextField = false;
  late StreamController<bool> tappedStatusSearchStreamController;
  late Sink<bool> tappedStatusSearchInputData;
  late Stream<bool> tappedStatusSearchOutputData;
  late StreamController<bool> closeStatusSearchStreamController;
  late Sink<bool> closeStatusSearchInputData;
  late Stream<bool> closeStatusSearchOutputData;
  late StreamController<List<SongsModel>> listSearchOutputDataStreamController;
  late Sink<List<SongsModel>> listSearchOutputDataInputData;
  late Stream<List<SongsModel>> listSearchOutputDataOutputData;
  List<SongsModel> listSearchModel = [];

  HomePageController() {
    tappedStatusSearchStreamController = StreamController();
    tappedStatusSearchInputData = tappedStatusSearchStreamController.sink;
    tappedStatusSearchOutputData = tappedStatusSearchStreamController.stream;
    closeStatusSearchStreamController = StreamController();
    closeStatusSearchInputData = closeStatusSearchStreamController.sink;
    closeStatusSearchOutputData = closeStatusSearchStreamController.stream;
    listSearchOutputDataStreamController = StreamController();
    listSearchOutputDataInputData = listSearchOutputDataStreamController.sink;
    listSearchOutputDataOutputData = listSearchOutputDataStreamController.stream.asBroadcastStream();
    tappedStatusSearchInputData.add(tappedOnSearchTextField);
    closeStatusSearchInputData.add(tappedOnSearchTextField);
    listSearchOutputDataInputData.add(listSearchModel);
  }

  static void navigatorToPlayMusicScreen(
      {required BuildContext context, required int index}) {
    Navigator.pushNamed(context, RoutesName.kPlayMusicScreen, arguments: index);
  }

  static void navigatorToPop({required BuildContext context}) {
    Navigator.pop(context);
  }

  void dispose() {
    tappedStatusSearchInputData.close();
    tappedStatusSearchStreamController.close();
  }

  void onTapSearchTextField() {
    tappedOnSearchTextField = true;
    tappedStatusSearchInputData.add(tappedOnSearchTextField);
    closeStatusSearchInputData.add(tappedOnSearchTextField);
  }

  void onTapOutsideSearchTextField() {
    tappedOnSearchTextField = false;
    tappedStatusSearchInputData.add(tappedOnSearchTextField);
    closeStatusSearchInputData.add(tappedOnSearchTextField);
    // FocusManager.instance.primaryFocus?.unfocus();
    // FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void searchAboutSong(String value) {
    List<SongsModel> a = ConstantsValue.listQuarn
        .where((element) => element.song.toLowerCase().contains(value))
        .toList();
    listSearchModel.clear();
    listSearchModel = a;
    listSearchOutputDataInputData.add(listSearchModel);

    // for (SongsModel s in a) print(s.song);
  }
}
