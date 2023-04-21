import Foundation
//  Created by Alexander Matheson
//  Created on 2023-Apr-21
//  Version 1.0
//  Copyright (c) 2023 Alexander Matheson. All rights reserved.
//
//  This program calculates a number based off of a chosen base and exponent.

// Enum for error checking
enum InputError: Error {
  case InvalidInput
}

// Input in separate function for error checking
func convert(strUnconverted: String) throws -> Int {
  guard let numConverted = Int(strUnconverted.trimmingCharacters(in: CharacterSet.newlines)) else {
    throw InputError.InvalidInput
  }
  return numConverted
}

// This function calculates an exponential number.
func power(base: Int, exponent: Int) -> Int {
  // Base case: when exponent = 0, the function exits.
  if exponent < 1 {
    return 1
  } else {
    return base * power(base: base, exponent: exponent - 1)
  }
}

// Read in lines from input.txt.
let inputFile = URL(fileURLWithPath: "input.txt")
let inputData = try String(contentsOf: inputFile)
let lineArray = inputData.components(separatedBy: .newlines)

// Open the output file for writing.
let outputFile = URL(fileURLWithPath: "output.txt")

// Call function and print to output file.
var powString = ""
for position in lineArray {
  // Split string into the base and exponent and convert to int.
  let equationComponents = position.components(separatedBy: " ")
  let baseConverted = try convert(strUnconverted: equationComponents[0])
  let exponentConverted = try convert(strUnconverted: equationComponents[1])

  // Check if exponent is negative.
  if exponentConverted < 0 {
    print("Exponent must be positive.")
  } else if baseConverted <= 0 {
    // If base is zero or less.
    print("Base must be positive.")
  } else {
    // Call function and output results.
    let calculated = power(base: baseConverted, exponent: exponentConverted)
    print(calculated)
    powString = powString + "\(calculated)\n"
    try powString.write(to: outputFile, atomically: true, encoding: .utf8)
  }
}
