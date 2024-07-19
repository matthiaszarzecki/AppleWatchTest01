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
      MenuView()
        .onAppear {
          session = WKExtendedRuntimeSession()
          session.delegate = delegate
          session.start()
        }
    }
  }
}

// define the delegate and its methods
class WKDelegate: NSObject, WKExtendedRuntimeSessionDelegate {
  func extendedRuntimeSession(
    _ extendedRuntimeSession: WKExtendedRuntimeSession,
    didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason,
    error: Error?
  ) {
    print(reason.rawValue)
  }

  func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    print("did start")
  }

  func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    print("will expire")
  }
}
