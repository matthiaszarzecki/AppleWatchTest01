//
//  HealthView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 28.07.24.
//

import SwiftUI

struct HealthView: View {
  @State var steps: Double = 0
  
  var body: some View {
    VStack {
      Text("Steps: \(steps)")
    }
    .onAppear {
      loadHealthData()
    }
  }

  func loadHealthData() {
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
