//
//  MenuView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 19.07.24.
//

import SwiftUI

struct BaseMenuView: View {
  @State var showTrainingDay = false
  @State var currentTrainingDay: TrainingDay = .day01

  @State var showHealthView = false
  @State var showLocationView = false

  @AppStorage("completed_days")
  var completedDays: [String] = []

  var body: some View {
    NavigationStack {
      List {
        ForEach(0..<TrainingDay.allDays.count, id: \.self) { index in
          let runHasBeenFinishedBefore = completedDays.contains(where: { $0 == TrainingDay.allDays[index].id })
          Button(
            action: {
              currentTrainingDay = TrainingDay.allDays[index]
              showTrainingDay = true
            },
            label: {
              ZStack {
                LinearGradient.runAppGradient
                  .frame(height: 48)
                Text("\(TrainingDay.allDays[index].name) - \(runHasBeenFinishedBefore)")
              }
              .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
          )
          // Necessary to disable default colors
          .background(Color.black.ignoresSafeArea())
          .listRowBackground(Color.black)
        }

        Button(
          action: {
            showHealthView = true
          },
          label: {
            Text("Health")
          }
        )

        Button(
          action: {
            showLocationView = true
          },
          label: {
            Text("Location")
          }
        )
      }
      .listStyle(.carousel)
      .navigationDestination(isPresented: $showTrainingDay) {
        RunView(
          currentSession: CurrentSession(
            trainingDay: currentTrainingDay
          )
        )
      }
      .navigationDestination(isPresented: $showHealthView) {
        HealthView()
      }
      .navigationDestination(isPresented: $showLocationView) {
        LocationView()
      }
    }
  }
}

#Preview {
  BaseMenuView()
}
