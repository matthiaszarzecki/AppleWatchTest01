//
//  MenuView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 19.07.24.
//

import SwiftUI

struct MenuView: View {
  @State var showTrainingDay = false
  @State var currentTrainingDay: TrainingDay = .day0

  var body: some View {
    NavigationStack {
      List {
        ForEach(0..<TrainingDay.allDays.count, id: \.self) { index in
          Button(
            action: {
              currentTrainingDay = TrainingDay.allDays[index]
              showTrainingDay = true
            },
            label: {
              Text(TrainingDay.allDays[index].name)
            }
          )
        }
      }
      .listStyle(.carousel)
      .navigationDestination(isPresented: $showTrainingDay) {
        RunView(
          currentSession: CurrentSession(trainingDay: currentTrainingDay)
        )
      }
    }
  }
}

#Preview {
  MenuView()
}
