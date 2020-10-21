//
//  ContentView.swift
//  UnitConverter
//
//  Created by Matt Donders on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    @State private var inputAmount = ""
    @State private var conversionType = 0
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    var standardLength: Double {
        // convert all inputs to mm (smallest amount)
        let nonStandardInput = Double(inputAmount) ?? 0
        var convertedInput: Double
        
        switch lengthUnits[inputUnit] {
        case "meters":
            convertedInput = nonStandardInput * 1000
        case "km":
            convertedInput = nonStandardInput * 1000000
        case "feet":
            convertedInput = nonStandardInput * 304.8
        case "yards":
            convertedInput = nonStandardInput * 914.4
        case "miles":
            convertedInput = nonStandardInput * 1609344
        default:
            convertedInput = 0
        }
        
        return convertedInput
    }
    
    
    var outputAmount: Double {
        // take standardLength (in mm) and convert it to outputUnit
        var convertedOutput: Double
        
        switch lengthUnits[outputUnit] {
        case "meters":
            convertedOutput = standardLength / 1000
        case "km":
            convertedOutput = standardLength / 1000000
        case "feet":
            convertedOutput = standardLength / 304.8
        case "yards":
            convertedOutput = standardLength / 914.4
        case "miles":
            convertedOutput = standardLength / 1609344
        default:
            convertedOutput = 0
        }
        
        return convertedOutput
    }
    
    let conversionTypes = ["length"]
    
    let lengthUnits = ["meters", "km", "feet", "yards", "miles"]
        
    var body: some View {
        NavigationView {
            Form {
//                Section(header: Text("Converstion Type")) {
//                    Picker("Conversion Type", selection: $conversionType) {
//                        ForEach(0 ..< conversionTypes.count) {
//                            Text("\(self.conversionTypes[$0])")
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
            
                
                Section(header: Text("Input Amount")) {
                    TextField("Input Amount", text: $inputAmount).keyboardType(.decimalPad)
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< lengthUnits.count) {
                            Text("\(self.lengthUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Ouput Amount")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0 ..< lengthUnits.count) {
                            Text("\(self.lengthUnits[$0])")
                        }
                    }              .pickerStyle(SegmentedPickerStyle())
                    Text("\(outputAmount, specifier: "%.2f")")
                    
                }
            }
        .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11 Pro")
    }
}
