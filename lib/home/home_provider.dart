import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class HomeProvider extends ChangeNotifier {
  String _status = "";

  String get status => _status;

  void init() async {
    const platform = MethodChannel('com.shivammishra.audio_jack_listener');

    // Set up a method channel to receive events
    platform.setMethodCallHandler((call) async {
      if (call.method == 'audioJackEvent') {
        debugPrint("Here");
        // Handle the event and update the UI
        _status = call.arguments;
      }
    });

    try {
      await platform.invokeMethod('startListeningForAudioJackEvents');
    } on PlatformException catch (e) {
      debugPrint("Failed to invoke platform method: '${e.message}'.");
    }
  }
}
