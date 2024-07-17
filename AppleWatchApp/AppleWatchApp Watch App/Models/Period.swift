//
//  Period.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 16.07.24.
//

import Foundation

struct Period {
  let type: PeriodType
  let duration: TimeInterval

  var description: String {
    switch type {
    case .warmUpWalk:
      "Warm Up Walk"
    case .intermediateWalk:
      "Walk"
    case .run:
      "Run"
    case .windDownWalk:
      "Wind Down"
    }
  }
}
