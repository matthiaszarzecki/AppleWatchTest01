//
//  CurrentSession.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 17.07.24.
//

import CoreLocation
import Foundation

struct CurrentSession {
  let trainingDay: TrainingDay
  
  // Use a datapoint-class that contains date, heartbeat and location?
  var dataPoints: [Date] = []
  var seconds = 0
  var startDate: Date?
  var endDate: Date?
  var locations: [CLLocation] = []
}
