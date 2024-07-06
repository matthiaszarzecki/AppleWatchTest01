//
//  ContentView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import SwiftUI

struct ContentView: View {
  @State private var timeRemaining = 90
  @State private var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
  @State private var periodsDone = 0
  @State private var vibrated = false

  var body: some View {
    VStack {
      Image(systemName: "timer")
        .imageScale(.large)
        .foregroundStyle(.tint)

      Text("Time Left: \(timeRemaining)s")
      Text("Periods Done: \(periodsDone)")
      Text("\(periodsDone.isMultiple(of: 2) ? "Walk" : "Run")")

      Button(
        action: {
          timer.connect()
          timeRemaining = 90
          periodsDone += 1
        },
        label: {
          Text(periodsDone == 0 ? "Start" : "Skip")
        }
      )

      Button(
        action: {
          timer = Timer.publish(every: 1, on: .main, in: .common)
          timeRemaining = 90
          periodsDone = 0
          vibrated = false
        },
        label: {
          Text("Reset")
        }
      )
    }
    .padding()
    .onReceive(timer) { _ in
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
    }
  }
}

#Preview {
  ContentView()
}
