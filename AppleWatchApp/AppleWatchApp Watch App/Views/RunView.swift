//
//  ContentView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import Combine
import SwiftUI

struct RunView: View {
  @State var runState: RunState = .hasNotStarted
  @State var currentSession: CurrentSession

  @State private var timeRemaining = 90
  @State private var currentPeriodIndex = 0
  @State private var hasVibrated = false
  @State private var currentDate: Date = .now

  private let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

  var body: some View {
    VStack {
      if runState == .hasNotStarted {
        Text(currentSession.trainingDay.name)
        startButton
      } else if runState == .inProgress {
        HStack {
          Image(systemName: "timer")
            .font(.system(size: 42))
            .foregroundStyle(.green)

          VStack {
            Text("Time Left: \(timeRemaining)s")
            Text("Interval: \(currentPeriodIndex + 1)/\(currentSession.trainingDay.periods.count)")
          }
        }

        if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
          Text(period.description)
            .foregroundStyle(period.color)
            .font(.system(size: 20))
        }

        HStack {
          Button(
            action: skipBackward,
            label: {
              Image(systemName: "arrow.left")
            }
          )

          Button(
            action: {
              vibrate()
            },
            label: {
              Image(systemName: "pause.fill")
            }
          )

          Button(
            action: skipForward,
            label: {
              Image(systemName: "arrow.right")
            }
          )
        }
      } else if runState == .finished {
        Text("You made it!")
        resetButton
        Text("DataPoints: \(currentSession.dataPoints.count)")
      }
    }
    .padding()
    .onReceive(timer) { value in
      update(value)
    }
    .navigationBarBackButtonHidden(runState == .inProgress)
  }

  private var startButton: some View {
    Button(
      action: {
        if currentPeriodIndex == 0 && runState == .hasNotStarted {
          runState = .inProgress

          if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
            timeRemaining = Int(period.duration)
          }

          hasVibrated = false
          vibrate()
        }
      },
      label: {
        Text("Start")
      }
    )
  }

  private var resetButton: some View {
    Button(
      action: {
        runState = .hasNotStarted
        currentPeriodIndex = 0
        if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
          timeRemaining = Int(period.duration)
        }

        hasVibrated = false
        currentSession.dataPoints = []
        vibrateReset()
      },
      label: {
        Text("Reset")
      }
    )
  }

  private func skipBackward() {
    currentPeriodIndex -= 1
    if currentPeriodIndex < 0 {
      currentPeriodIndex = 0
      runState = .hasNotStarted
    }

    if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
      timeRemaining = Int(period.duration)
    }

    hasVibrated = false
    vibrate()
  }

  private func skipForward() {
    if currentPeriodIndex >= currentSession.trainingDay.periods.count - 1 {
      runState = .finished
    } else {
      currentPeriodIndex += 1
      if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
        timeRemaining = Int(period.duration)
      }
    }

    hasVibrated = false
    vibrate()
  }

  private func update(_ date: Date) {
    print(date)
    currentDate = date

    if runState == .inProgress {
      if timeRemaining > 0 {
        // Regular Interval - Count Down
        hasVibrated = false
        timeRemaining -= 1
        currentSession.dataPoints.append(Date())
      } else if timeRemaining <= 0 && !hasVibrated {
        // Timer Reached Zero - Set to next period
        vibrate()
        hasVibrated = true

        // TODO: See if this actually works
        if currentPeriodIndex >= currentSession.trainingDay.periods.count - 1 {
          // Run is Finished
          runState = .finished
        } else {
          currentPeriodIndex += 1
          if let period = currentSession.trainingDay.periods[safe: currentPeriodIndex] {
            timeRemaining = Int(period.duration)
          }
        }
      }
    }
  }

  private func vibrate() {
    WKInterfaceDevice.current().play(.notification)
  }

  private func vibrateReset() {
    WKInterfaceDevice.current().play(.failure)
  }
}

#Preview("Has Not Started") {
  RunView(
    runState: .hasNotStarted,
    currentSession: CurrentSession(trainingDay: .day0)
  )
}

#Preview("In Progress") {
  RunView(
    runState: .inProgress,
    currentSession: CurrentSession(trainingDay: .day0)
  )
}

#Preview("Finished") {
  RunView(
    runState: .finished,
    currentSession: CurrentSession(trainingDay: .day0)
  )
}
