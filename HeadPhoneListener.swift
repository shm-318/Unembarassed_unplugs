//
//  HeadPhoneListener.swift
//  Runner
//
//  Created by Shivam Mishra on 17/03/24.
//

import Cocoa
import FlutterMacOS

public class AudioJackListener: NSObject, FlutterPlugin {
  private var methodChannel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.shivammishra.audio_jack_listener",
                                       binaryMessenger: registrar.messenger)
    let instance = AudioJackListener()
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance.methodChannel = channel
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startListeningForAudioJackEvents":
      print("Received method call: startListeningForAudioJackEvents")
      startListeningForAudioJackEvents()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func startListeningForAudioJackEvents() {
    let notificationCenter = DistributedNotificationCenter.default()

    // Add observer for the headphone plugged-in event
    notificationCenter.addObserver(forName: NSNotification.Name("com.apple.audio.DeviceSettingsChangedNotification"), object: nil, queue: nil) { notification in
      let audioDevices = notification.userInfo?["AudioDevices"] as? [String: AnyObject]

      // Check if headphone is present in the audio devices
      if let audioDevices = audioDevices, let headphoneDevice = audioDevices["Headphones"] {
        if let isPluggedIn = headphoneDevice["device-is-plugged-in"] as? Bool {
          if isPluggedIn {
            // Headphone plugged in

            self.sendEvent("Headphone plugged in")
          } else {
            // Headphone removed
            self.sendEvent("Headphone removed")
          }
        }
      } else {
        // No headphone detected
        self.sendEvent("No headphone detected")
      }
    }
  }

  private func sendEvent(_ message: String) {
    methodChannel?.invokeMethod("audioJackEvent", arguments: message)
  }
}

