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
        Button(
          action: {
            currentTrainingDay = .debugDay
            showTrainingDay = true
          },
          label: {
            Text("Debug")
          }
        )

        Button(
          action: {
            currentTrainingDay = .day0
            showTrainingDay = true
          },
          label: {
            Text("Day 1")
          }
        )

        Button(
          action: {
            currentTrainingDay = .day0
            showTrainingDay = true
          },
          label: {
            Text("Day 2")
          }
        )
      }
      .listStyle(.carousel)
      .navigationDestination(isPresented: $showTrainingDay) {
        RunView(currentSession: CurrentSession(trainingDay: currentTrainingDay))
      }
    }
  }
}

#Preview {
  MenuView()
}
