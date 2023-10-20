import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_assessment/injection_container.dart';
import 'package:mobile_assessment/root_widget.dart';

Future<void> main() async {
  init();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const MobileAssessmentApp(
      isDebug: true,
    ));
  }, (exception, stackTrace) async {});
}
