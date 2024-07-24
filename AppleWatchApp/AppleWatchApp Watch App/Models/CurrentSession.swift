//
//  CurrentSession.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 17.07.24.
//

import Foundation

struct CurrentSession {
  let trainingDay: TrainingDay
  
  var dataPoints: [Date] = []
  var seconds = 0
}
