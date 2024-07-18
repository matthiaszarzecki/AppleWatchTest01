//
//  ContentView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import Combine
import SwiftUI

struct RunView: View {
  @State private var timeRemaining = 90
  @State private var currentPeriodIndex = 0
  @State private var vibrated = false

  @State private var timer: AnyCancellable?
  @State private var currentSession = CurrentSession()
  @State private var hasStarted = false

  var body: some View {
    VStack {
      HStack {
        Image(systemName: "timer")
          .imageScale(.large)
          .foregroundStyle(.green)

        VStack {
          Text("Time Left: \(timeRemaining)s")
          Text("Interval: \(currentPeriodIndex)/\(currentSession.trainingDay.periods.count)")

          if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
            Text(period.description)
              .foregroundStyle(period.color)
          }
        }
      }
      HStack {
        // Reset Button
        Button(
          action: {
            //timer = Timer.publish(every: 1, on: .main, in: .common)
            timer?.cancel()

            hasStarted = false
            currentPeriodIndex = 0
            if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
              timeRemaining = Int(period.duration)
            }

            vibrated = false
            currentSession.dataPoints = []
            WKInterfaceDevice.current().play(.failure)
          },
          label: {
            Text("Reset")
          }
        )

        // Start / Skip button
        Button(
          action: {
            if currentPeriodIndex == 0 && !hasStarted {
              hasStarted = true
              assignTimer()
            } else {
              currentPeriodIndex += 1
            }

            if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
              timeRemaining = Int(period.duration)
            }

            vibrated = false
            WKInterfaceDevice.current().play(.notification)
          },
          label: {
            Text(currentPeriodIndex == 0 && !hasStarted ? "Start" : "Skip")
          }
        )
      }

      Text("DataPoints: \(currentSession.dataPoints.count)")
    }
    .padding()
  }

  private func assignTimer() {
    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { value in
        print(value)

        if hasStarted {
          if timeRemaining > 0 {
            // Regular Interval - Count Down
            vibrated = false
            timeRemaining -= 1
            currentSession.dataPoints.append(Date())
          }
          if timeRemaining <= 0 && !vibrated {
            // Timer Reached Zero - Reset
            WKInterfaceDevice.current().play(.notification)
            vibrated = true

            currentPeriodIndex += 1
            if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
              timeRemaining = Int(period.duration)
            }
          }
        }
      }
  }
}

#Preview {
  RunView()
}
