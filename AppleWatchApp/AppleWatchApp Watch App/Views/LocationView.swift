//
//  LocationView.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 28.07.24.
//

import SwiftUI

struct LocationView: View {
  @StateObject var locationManager = LocationManager()
  
  var userLatitude: String {
    "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
  }

  var userLongitude: String {
    "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
  }

  var body: some View {
    VStack {
      Text("location status: \(locationManager.statusString)")
      HStack {
        Text("latitude: \(userLatitude)")
        Text("longitude: \(userLongitude)")
      }

      Button(
        action: {
          locationManager.request()
        },
        label: {
          Text("Request Location Access")
        }
      )
    }
  }
}
