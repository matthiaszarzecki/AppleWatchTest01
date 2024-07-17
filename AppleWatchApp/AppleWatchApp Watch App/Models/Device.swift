//
//  Device.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 17.07.24.
//

import Foundation

class Device {
  static var isSimulator: Bool {
    #if targetEnvironment(simulator)
      true
    #else
      false
    #endif
  }
}
