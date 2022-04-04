//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars

import 'package:audioplayers/audioplayers_web.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:sensors_plus_web/sensors_plus_web.dart';
import 'package:share_plus_web/share_plus_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioplayersPlugin.registerWith(registrar);
  ImagePickerPlugin.registerWith(registrar);
  ImagePickerWeb.registerWith(registrar);
  SensorsPlugin.registerWith(registrar);
  SharePlusPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
