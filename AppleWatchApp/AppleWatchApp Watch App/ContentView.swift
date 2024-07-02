//
//  ContentView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 30.06.24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)

      Button(
        action: {},
        label: {
          Text("Button!")
        }
      )
    }
    .padding()
  }


  @State var secondsElapsed = 0
  var timer = Timer()
  @State var isTimerRunning = false
  @State var resumeTapped = false

  /*override func viewDidLoad() {
      pauseButton.isEnabled = false
      super.viewDidLoad()
  }
  */

  func runTimer() {
    /*timer = Timer.scheduledTimer(
     timeInterval: 1,
     target: self,
     selector: (#selector(ViewController.updateTimer)),
     userInfo: nil,
     repeats: true
     )
     pauseButton.isEnabled = true*/
  }

  func updateTimer() {
    if secondsElapsed < 1 {
      timer.invalidate()
    } else {
      secondsElapsed += 1
      //updateDisplay()
    }
  }

  func pauseButtonClicked() {
    if self.resumeTapped == false {
      timer.invalidate()
      //self.resumeTapped = true
      //self.pauseButton.setTitle("Resume", for: .normal)
    } else {
      //runTimer()
      //self.resumeTapped = false
      //self.pauseButton.setTitle("Pause", for: .normal)
    }
  }

  func startButtonClicked() {
    if !isTimerRunning {
      //runTimer()
      isTimerRunning = true
      //self.startButton.isEnabled = false
    }
  }

  func reset() {
    timer.invalidate()
    secondsElapsed = 0
    //updateDisplay()
    isTimerRunning = false
    //pauseButton.isEnabled = false
    //startButton.isEnabled = true
  }

  private func timeString(time: TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
  }
}

#Preview {
  ContentView()
}
