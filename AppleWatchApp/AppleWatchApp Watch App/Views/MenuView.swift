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
  @State var steps: Double = 0

  var body: some View {
    let gradient = Gradient(colors: [.yellow, .blue])

    NavigationStack {
      List {
        Text("Steps: \(steps)")
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
          currentSession: CurrentSession(
            trainingDay: currentTrainingDay
          )
        )
      }
    }
    .onAppear {
      loadData()
    }
  }

  func loadData() {
    // Create custom HealthStore
    // Request permission from User. A standard iOS
    // HealthKit Permission Overlay will appear.
    HealthStore.shared.requestAuthorization { success in

      // Permission Granted.
      if success {

        // Get actual data we want to display.
        HealthStore.shared.calculateSteps { statisticsCollection in
          if let statisticsCollection = statisticsCollection {

            // Reset steps here for later fresh appending
            //self.state.steps = [Step]()

            //self.steps =
            /*self.updateUIFromStatistics(
              statisticsCollection: statisticsCollection
            )*/

            let startDate = Calendar.current.date(
              byAdding: .day,
              value: -6, to: Date()
            )!
            let endDate = Date()

            statisticsCollection.enumerateStatistics(
              from: startDate,
              to: endDate
            ) { statistics, stop in
              let count = statistics.sumQuantity()?.doubleValue(for: .count())
              self.steps = count ?? -1
              /*let step = Step(
               count: Int(count ?? 0),
               date: statistics.startDate
               )
               self.state.steps.append(step)*/
            }
          }
        }
      }
    }
  }
}

#Preview {
  MenuView()
}
