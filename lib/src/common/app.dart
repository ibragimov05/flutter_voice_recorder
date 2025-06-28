import 'package:flutter/material.dart';

import '../feature/screens/voice_recorder_screen.dart';

/// {@template app}
/// A widget that is the root of the application.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

/// State for the app.
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Voice Recorder Demo',
    theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    home: const VoiceRecorderScreen(),
  );
}
