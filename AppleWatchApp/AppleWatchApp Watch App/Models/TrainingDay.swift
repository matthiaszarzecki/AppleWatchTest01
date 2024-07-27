//
//  TrainingDay.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 16.07.24.
//

import Foundation

struct TrainingDay: Identifiable {
  let name: String
  let id: String
  let periods: [Period]

  var numberOfRunPeriods: Int {
    periods.filter { $0.type == .run }.count
  }
}

extension TrainingDay {
  static let debugDay = TrainingDay(
    name: "Debug Day",
    id: "debug_day",
    periods: [
      Period(type: .warmUpWalk, duration: 5),
      Period(type: .run, duration: 5),
      Period(type: .intermediateWalk, duration: 5),
      Period(type: .run, duration: 5),
      Period(type: .windDownWalk, duration: 5)
    ]
  )

  static let day01 = TrainingDay(
    name: "Day 1 - 90s x8",
    id: "day_01",
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

  static let day02 = TrainingDay(
    name: "Day 2 - 90s x8",
    id: "day_02",
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

  static let day07 = TrainingDay(
    name: "Day 7 - 90s, 3min x2",
    id: "day_07",
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
    .day01,
    .day02,
    .day07
  ]
}
