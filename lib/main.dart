import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'src/common/app.dart';

void main() => runZonedGuarded<void>(
  () => runApp(const App()),
  (error, stack) => log(error.toString(), stackTrace: stack, name: 'main'),
);
