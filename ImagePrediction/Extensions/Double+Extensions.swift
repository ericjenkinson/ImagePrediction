//
//  Double+Extensions.swift
//  ImagePrediction
//
//  Created by Eric Jenkinson on 12/28/23.
//

import Foundation

extension Double {
  func roundTo(decimalPlaces: Int) -> String {
    String(format: "%.\(decimalPlaces)f%%", self * 100)
  }
}
