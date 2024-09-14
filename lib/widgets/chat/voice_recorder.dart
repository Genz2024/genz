import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceRecorder {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  Future<void> startRecording() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
    await _recorder.startRecorder();
  }

  Future<String?> stopRecording() async {
    var path = await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    return path;
  }
}
