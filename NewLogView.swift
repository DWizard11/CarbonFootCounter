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
    @State var isAlertPresent = false
    @ObservedObject var carbonLogManager: CarbonLogManager
    @Binding var carbonLogs: [CarbonLog]
    var logIndex: Int
    @State var currentDate: Date
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
                if activity == "" && carbonFootprint == 0 {
                    isAlertPresent.toggle()
                } else if logIndex == 0 {
                    let carbonLog = CarbonLog(name: [], footprint: [], notes: [])
                    carbonLogs.append(carbonLog)
                    carbonLogs[logIndex].name.insert(activity, at: 0)
                    carbonLogs[logIndex].footprint.insert(carbonFootprint, at: 0)
                    dismiss()
                } else {
                    carbonLogs[logIndex].name.append(activity)
                    carbonLogs[logIndex].footprint.append(carbonFootprint)
                    dismiss()
                }
            } label: {
                Text("Add New Log")
            }
            .buttonStyle(.bordered)
            .alert(isPresented: $isAlertPresent) {
                Alert(title: Text("Error"), message: Text("Please ensure the values are not empty."), dismissButton: .cancel())
            }
            
        }
    }
}


