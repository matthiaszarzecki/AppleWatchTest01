//
//  TrainingDay.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 16.07.24.
//

import Foundation

struct TrainingDay {
  let periods: [Period]

  var numberOfRunPeriods: Int {
    periods.filter { $0.type == .run }.count
  }
}

extension TrainingDay {
  static let day0 = TrainingDay(
    periods: [
      Period(type: .warmUpWalk, duration: 90),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 60),
      Period(type: .windDownWalk, duration: 90)
    ]
  )

  static let debugDay = TrainingDay(
    periods: [
      Period(type: .warmUpWalk, duration: 5),
      Period(type: .run, duration: 5),
      Period(type: .intermediateWalk, duration: 5),
      Period(type: .run, duration: 5),
      Period(type: .windDownWalk, duration: 5)
    ]
  )
}
