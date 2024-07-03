//
//  ContentView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import SwiftUI

struct ContentView: View {
  @State var timeRemaining = 90
  @State private var currentDate = Date.now
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  @State var vibrated = false

  var body: some View {
    VStack {
      Image(systemName: "timer")
        .imageScale(.large)
        .foregroundStyle(.tint)

      Text("\(currentDate)")

      Text("Time Left: \(timeRemaining)s")

      Button(
        action: {
          timeRemaining = 90
        },
        label: {
          Text("Reset")
        }
      )
    }
    .padding()
    .onReceive(timer) { input in
      if timeRemaining > 0 {
        vibrated = false
        timeRemaining -= 1
      }
      if timeRemaining <= 0 && !vibrated {
        WKInterfaceDevice.current().play(.failure)
        vibrated = true
      }
      currentDate = input
    }
  }
}

#Preview {
  ContentView()
}
