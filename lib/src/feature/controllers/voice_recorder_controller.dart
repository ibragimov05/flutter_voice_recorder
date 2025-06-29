part of '../screens/voice_recorder_screen.dart';

/// {@template voice_controller}
/// A controller for the voice recorder screen.
/// {@endtemplate}
abstract class VoiceRecorderController extends State<VoiceRecorderScreen> {
  /// {@macro voice_controller}
  VoiceRecorderController();

  /// Recorder instance.
  final AudioRecorder _recorder = AudioRecorder();

  /// Player instance.
  final AudioPlayer _player = AudioPlayer();

  /// Timer instance.
  Timer? _timer;

  /// Whether the user is recording.
  bool _isRecording = false;

  /// Whether the recordings are being fetched.
  bool _isFetchingRecordings = true;

  /// Permission status.
  PermissionStatus? _permissionStatus;

  /// Directory instance.
  Directory? _directory;

  /// Recordings in a set.
  final _recordings = <String>{};

  /// Method to fetch all recordings from the application documents directory.
  Future<void> _fetchAllRecordings() async {
    try {
      final files = _directory?.listSync() ?? [];

      for (final file in files) {
        if (file.path.endsWith('.mp3')) _recordings.add(file.path);
      }

      setState(() => _isFetchingRecordings = false);
    } on Object catch (e, s) {
      severe(e, stackTrace: s);
    }
  }

  /// Method to start recording.
  Future<void> _startRecording() async {
    try {
      if (_permissionStatus?.isGranted != true) return;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${_directory?.path}/recording_$timestamp.mp3';

      await _recorder.start(const RecordConfig(encoder: AudioEncoder.aacLc), path: path);

      setState(() => _isRecording = true);
    } on Object catch (e, s) {
      severe(e, stackTrace: s);
    }
  }

  /// Method to stop recording.
  Future<void> _stopRecording(LongPressEndDetails _) async {
    try {
      _timer?.cancel();

      final path = await _recorder.stop();

      if (path != null) _recordings.add(path);

      setState(() => _isRecording = false);
    } on Object catch (e, s) {
      severe(e, stackTrace: s);
    }
  }

  /// Method to play an audio from a given path.
  Future<void> _playAudio(String path) async {
    try {
      await _player.setFilePath(path);
      await _player.play();
    } on Object catch (e, s) {
      severe(e, stackTrace: s);
    }
  }

  /// Method to delete a recording from a given path.
  void _deleteRecording(String path) {
    try {
      File(path).deleteSync();

      setState(() => _recordings.remove(path));
    } on Object catch (e, s) {
      severe(e, stackTrace: s);
    }
  }

  Future<void> _init() async {
    _directory = await getApplicationDocumentsDirectory();
    _permissionStatus = await Permission.microphone.request();
  }

  /* #region lifecycle */

  @override
  void initState() {
    super.initState();

    _init().ignore();
    _fetchAllRecordings().ignore();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /* #endregion */
}
