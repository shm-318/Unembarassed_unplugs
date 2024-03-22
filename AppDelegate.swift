import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
         return true
  }
  override func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let controller = NSApplication.shared.windows.first?.contentViewController as? FlutterViewController else {
                    fatalError("Unable to get FlutterViewController")
                }
           let channel = FlutterMethodChannel(name: "com.shivammishra.audio_jack_listener",
                                              binaryMessenger: controller.engine.binaryMessenger)
           let instance = AudioJackListener()
           channel.setMethodCallHandler(instance.handle)
        
    }
}
