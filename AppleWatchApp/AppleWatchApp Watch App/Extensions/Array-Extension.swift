//
//  Array-Extension.swift
//  AppleWatchApp Watch App
//
//  Created by Matthias Zarzecki on 28.07.24.
//

import Foundation

// TODO: Try this with a Set, not an array
extension Array: RawRepresentable where Element: Codable {
  public init?(rawValue: String) {
    guard
      let data = rawValue.data(using: .utf8),
      let result = try? JSONDecoder().decode([Element].self, from: data)
    else {
      return nil
    }
    self = result
  }

  public var rawValue: String {
    guard
      let data = try? JSONEncoder().encode(self),
      let result = String(data: data, encoding: .utf8)
    else {
      return "[]"
    }
    return result
  }
}
