//
//  LinearGradient-Extension.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 27.07.24.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
  static var runAppGradient: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.yellow, .blue]),
      startPoint: .bottomTrailing,
      endPoint: .topLeading
    )
  }
}
