//
//  ContentView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import Combine
import HealthKit
import SwiftUI

struct RunView: View {
  @State var runState: RunState = .hasNotStarted
  @State var currentSession: CurrentSession

  @State private var timeRemaining = 90
  @State private var currentPeriodIndex = 0
  @State private var hasVibrated = false
  @State private var currentDate: Date = .now

  @State private var heartRate: Double = 0

  private let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

  var body: some View {
    GeometryReader { geometry in
      let width = geometry.size.width
      let heightUpperPart = geometry.size.height * 0.6
      let heightLowerPart = geometry.size.height * 0.4

      VStack {
        if runState == .hasNotStarted {
          Text(currentSession.trainingDay.name)
          startButton

          Button(
            action: {
              getHeartRate()
            },
            label: {
              Text("Get Heart Rate")
            }
          )
          Text("Heart Rate: \(heartRate)")
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
                runState = .paused
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
        } else if runState == .paused {
          Text("Run Paused")
          Button(
            action: {
              runState = .inProgress
              vibrate()
            },
            label: {
              Text("Continue")
            }
          )
        } else if runState == .finished {
          VStack {
            VStack {
              Text("You made it!")
              Text("Seconds: \(currentSession.seconds)")
              Text("DataPoints: \(currentSession.dataPoints.count)")
            }
            .frame(width: width, height: heightUpperPart)

            VStack {
              resetButton
            }
            .frame(width: width, height: heightLowerPart)
          }
          .background(.runAppGradient)
        }
      }
    }
    .onReceive(timer) { value in
      update(value)
    }
    .navigationBarBackButtonHidden(runState == .inProgress || runState == .paused)
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
        currentSession.seconds += 1
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

  private func getHeartRate() {
    let healthStore = HKHealthStore()
    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let date = Date()
    let predicate = HKQuery.predicateForSamples(
      withStart: date.addingTimeInterval(-60),
      end: date,
      options: .strictEndDate
    )
    let query = HKStatisticsQuery(
      quantityType: heartRateType,
      quantitySamplePredicate: predicate,
      options: .discreteAverage
    ) { _, result, _ in
      guard let result = result, let quantity = result.averageQuantity() else {
        return
      }
      heartRate = quantity.doubleValue(for: HKUnit(from: "count/min"))
    }
    healthStore.execute(query)
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
    currentSession: CurrentSession(trainingDay: .day01)
  )
}

#Preview("In Progress") {
  RunView(
    runState: .inProgress,
    currentSession: CurrentSession(trainingDay: .day01)
  )
}

#Preview("Paused") {
  RunView(
    runState: .paused,
    currentSession: CurrentSession(trainingDay: .day01)
  )
}

#Preview("Finished") {
  RunView(
    runState: .finished,
    currentSession: CurrentSession(trainingDay: .day01)
  )
}
