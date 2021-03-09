import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

bool isAndroid(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.android;

bool isIOS(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS;
