//
//  DottedLine.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/07/2022.
//
import Foundation

extension String {
    static let numberFormatter = NumberFormatter()
    var floatValue: Float {
        String.numberFormatter.decimalSeparator = "."
        if let result = String.numberFormatter.number(from: self) {
              return result.floatValue
          } else {
              String.numberFormatter.decimalSeparator = ","
              if let result = String.numberFormatter.number(from: self) {
                  return result.floatValue
              }
          }
          return 0
      }
       
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
