//
//  TrainingDay.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 16.07.24.
//

import Foundation

struct TrainingDay {
  let name: String
  let periods: [Period]

  var numberOfRunPeriods: Int {
    periods.filter { $0.type == .run }.count
  }
}

extension TrainingDay {
  static let debugDay = TrainingDay(
    name: "Debug Day",
    periods: [
      Period(type: .warmUpWalk, duration: 5),
      Period(type: .run, duration: 5),
      Period(type: .intermediateWalk, duration: 5),
      Period(type: .run, duration: 5),
      Period(type: .windDownWalk, duration: 5)
    ]
  )

  static let day1 = TrainingDay(
    name: "Day 1 - 90s x8",
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

  static let day2 = TrainingDay(
    name: "Day 2 - 90s x8",
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

  static let day3 = TrainingDay(
    name: "Day 7 - 90s, 3min x2",
    periods: [
      Period(type: .warmUpWalk, duration: 90),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 90),
      Period(type: .run, duration: 180),
      Period(type: .intermediateWalk, duration: 180),
      Period(type: .run, duration: 90),
      Period(type: .intermediateWalk, duration: 90),
      Period(type: .run, duration: 180),
      Period(type: .intermediateWalk, duration: 180),
      Period(type: .windDownWalk, duration: 90)
    ]
  )

  static let allDays: [TrainingDay] = [
    .debugDay,
    .day1,
    .day2,
    .day3
  ]
}
