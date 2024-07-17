//
//  CurrentSession.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 17.07.24.
//

import Foundation

struct CurrentSession {
  let trainingDay: TrainingDay = .day0
  
  var dataPoints: [Date] = []
}
