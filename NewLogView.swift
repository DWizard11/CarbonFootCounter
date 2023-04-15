//
//  NewLogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 8/4/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct NewLogView: View {
    
    @State var activity = ""
    @State var carbonFootprint = Int()
    @State var notes = ""
    @State var isAlertPresent = false
    @ObservedObject var carbonLogManager: CarbonLogManager
    @Binding var carbonLogs: [CarbonLog]
    var logIndex: Int
    @AppStorage("shown") var alertShownOnce: Bool = false
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
            
            TextField("Add Notes", text: $notes, axis: .vertical)
                .font(.headline)
                .padding()
            
            Button {
                if activity == "" && carbonFootprint == 0 {
                    isAlertPresent.toggle()
                } else if !alertShownOnce {
                    let carbonLog = CarbonLog(name: [activity], footprint: [carbonFootprint], notes: [notes], date: currentDate)
                    carbonLogs.append(carbonLog)
                    print("HEHEHHEHAW")
                    print(carbonLogManager.carbonLogs)
                    alertShownOnce = true
                    dismiss()
                } else {
                    carbonLogs[logIndex].name.append(activity)
                    carbonLogs[logIndex].footprint.append(carbonFootprint)
                    carbonLogs[logIndex].notes.append(notes)
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


