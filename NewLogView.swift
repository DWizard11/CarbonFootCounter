//
//  NewLogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 8/4/23.
//

import SwiftUI

struct NewLogView: View {
    
    @State var activity = ""
    @State var carbonFootprint = Int()
    @ObservedObject var carbonLogManager: CarbonLogManager
    @Environment(\.dismiss) var dismiss
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()

    var body: some View {
        VStack {
            TextField("Activity", text: $activity)
                .font(.headline)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Type of Activity", value: $carbonFootprint, formatter: formatter)
                .textFieldStyle(.roundedBorder)
                .padding()
                .keyboardType(.decimalPad)
            
            Button {
                dismiss()
            } label: {
                Text("Add New Log")
            }
            .buttonStyle(.bordered)
            
        }
    }
}


