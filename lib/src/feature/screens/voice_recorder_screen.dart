import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../common/logger.dart';

part '../controllers/voice_controller.dart';

/// {@template voice_recorder}
/// A widget that allows the user to record voice messages.
/// {@endtemplate}
class VoiceRecorderScreen extends StatefulWidget {
  /// {@macro voice_recorder}
  const VoiceRecorderScreen({super.key});

  @override
  State<VoiceRecorderScreen> createState() => _VoiceRecorderScreenState();
}

/// State for the voice recorder screen.
class _VoiceRecorderScreenState extends VoiceController {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Voice Recorder'), backgroundColor: Colors.blue),
    body: Column(
      children: [
        // Recordings list
        Expanded(
          child: switch (_isFetchingRecordings) {
            _ when _recordings.isEmpty => const Center(child: Text('No recordings found')),
            true => const Center(child: RepaintBoundary(child: CircularProgressIndicator())),
            false => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _recordings.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) => ListTile(
                tileColor: Colors.grey.withValues(alpha: .1),
                leading: const Icon(Icons.audio_file),
                title: Text('Recording ${index + 1}'),
                subtitle: Text(_recordings.elementAt(index)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () => _deleteRecording(_recordings.elementAt(index)),
                ),
                onTap: () => _playAudio(_recordings.elementAt(index)),
              ),
            ),
          },
        ),

        // Record button
        Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onLongPress: _startRecording,
            onLongPressEnd: _stopRecording,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: switch (_isRecording) {
                  true => Colors.red.withValues(alpha: .5),
                  false => Colors.blue.withValues(alpha: .5),
                },
                shape: BoxShape.circle,
              ),
              child: const Padding(padding: EdgeInsets.all(16), child: Icon(Icons.mic)),
            ),
          ),
        ),
      ],
    ),
  );
}
