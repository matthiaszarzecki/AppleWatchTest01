//
//  HealthView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 28.07.24.
//

import HealthKit
import SwiftUI

struct HealthView: View {
  @State var steps: Double = 0
  @State private var heartRate: Double = 0

  var body: some View {
    VStack {
      Text("Steps: \(steps)")
      
      Button(
        action: getHeartRate,
        label: {
          Text("Get Heart Rate")
        }
      )
      Text("Heart Rate: \(heartRate)")
    }
    .onAppear {
      loadHealthData()
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
