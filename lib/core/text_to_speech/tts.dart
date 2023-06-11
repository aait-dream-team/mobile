import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechSingleton {
  static TextToSpeechSingleton? _instance;
  TextToSpeech _tts;
  bool _soundEnabled;

  factory TextToSpeechSingleton() {
    _instance ??= TextToSpeechSingleton._();
    return _instance!;
  }

  TextToSpeechSingleton._()
      : _tts = TextToSpeech(),
        _soundEnabled = true;

  bool get soundEnabled => _soundEnabled;

  set soundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  void speak(String text) {
    if (_soundEnabled) {
      _tts.speak(text);
    }
  }
}
