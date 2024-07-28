//
//  AppleWatchAppApp.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import SwiftUI

@main
struct AppleWatchApp_Watch_AppApp: App {
  var body: some Scene {
    @State var session = WKExtendedRuntimeSession()
    @State var delegate = WKDelegate()

    WindowGroup {
      BaseMenuView()
        .onAppear {
          session = WKExtendedRuntimeSession()
          session.delegate = delegate
          session.start()
        }
    }
  }
}

/// Delegate for the WKExtendedRuntimeSession. Is necessary to keep
/// the Apple Watch App from auto-closing. Works up to 1 hour.
class WKDelegate: NSObject, WKExtendedRuntimeSessionDelegate {
  func extendedRuntimeSession(
    _ extendedRuntimeSession: WKExtendedRuntimeSession,
    didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason,
    error: Error?
  ) {
    print(reason.rawValue)
  }

  func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    print("Did start healthkit runtime session")
  }

  func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    print("Healthkit runtime session will expire")
  }
}
