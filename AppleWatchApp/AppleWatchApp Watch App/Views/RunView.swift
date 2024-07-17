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

  var body: some View {
    VStack {
      HStack {
        Image(systemName: "timer")
          .imageScale(.large)
          .foregroundStyle(.green)

        VStack {
          Text("Time Left: \(timeRemaining)s")
          Text("Interval: \(currentPeriodIndex)/\(currentSession.trainingDay.periods.count)")

          let description = currentSession.trainingDay.periods[safe: currentPeriodIndex]?.description ?? ""
          Text(description)

          if currentPeriodIndex.isMultiple(of: 2) {
            Text("Walk")
              .foregroundStyle(.red)
          } else {
            Text("Run")
              .foregroundStyle(.green)
          }
        }
      }
      HStack {
        Button(
          action: {
            //timer = Timer.publish(every: 1, on: .main, in: .common)
            timer?.cancel()
            timeRemaining = 90
            currentPeriodIndex = 0
            vibrated = false
            currentSession.dataPoints = []
            WKInterfaceDevice.current().play(.failure)
          },
          label: {
            Text("Reset")
          }
        )

        Button(
          action: {
            if currentPeriodIndex == 0 {
              assignTimer()
            }
            timeRemaining = 90
            currentPeriodIndex += 1
            vibrated = false
            WKInterfaceDevice.current().play(.notification)
          },
          label: {
            Text(currentPeriodIndex == 0 ? "Start" : "Skip")
          }
        )
      }

      Text("DataPoints: \(currentSession.dataPoints.count)")
    }
    .padding()
    /*.onReceive(timer) { _ in
      if timeRemaining > 0 {
        vibrated = false
        timeRemaining -= 1
      }
      if timeRemaining <= 0 && !vibrated {
        WKInterfaceDevice.current().play(.failure)
        vibrated = true
        timeRemaining = 90
        periodsDone += 1
      }
    }*/
  }

  private func assignTimer() {
    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { value in
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
          timeRemaining = 90
          currentPeriodIndex += 1
        }
      }
  }
}

#Preview {
  RunView()
}
