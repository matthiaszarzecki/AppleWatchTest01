//
//  MenuView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 19.07.24.
//

import SwiftUI

struct MenuView: View {
  @State var showTrainingDay = false
  @State var currentTrainingDay: TrainingDay = .day1

  var body: some View {
    let gradient = Gradient(colors: [.yellow, .blue])

    NavigationStack {
      List {
        ForEach(0..<TrainingDay.allDays.count, id: \.self) { index in
          Button(
            action: {
              currentTrainingDay = TrainingDay.allDays[index]
              showTrainingDay = true
            },
            label: {
              ZStack {
                LinearGradient(gradient: gradient, startPoint: .bottomTrailing, endPoint: .topLeading)
                  .frame(height: 48)
                Text(TrainingDay.allDays[index].name)
              }
              .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
          )
          // Necessary to disable default colors
          .background(Color.black.ignoresSafeArea())
          .listRowBackground(Color.black)
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
