//
//  Period.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 16.07.24.
//

import Foundation

enum PeriodType {
  case warmUpWalk
  case intermediateWalk
  case run
  case windDownWalk
}

struct Period {
  let type: PeriodType
  let duration: TimeInterval
}
