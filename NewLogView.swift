//
//  NewLogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 8/4/23.
//

import SwiftUI
import Combine

@available(iOS 16.0, *)
struct NewLogView: View {
    
    @State var activity = ""
    @State var carbonFootprint = 7.2
    @State var notes = ""
    @State var isAlertPresent = false
    @ObservedObject var carbonLogManager: CarbonLogManager
    @Binding var carbonLogs: [CarbonLog]
    var logIndex: Int
    @AppStorage("shown") var alertShownOnce: Bool = false
    @State var currentDate: Date
    @State var logActivities = ["Car": 7.2, "Beef": 99.48, "Eggs": 1.6]
    @State var selectedFootPrint = ""
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
            HStack {
                Picker(selection: $selectedFootPrint) {
                    ForEach(Array(logActivities.keys), id: \.self) { key in
                        Text(key).tag(key)
                    }
                } label: {
                    Text("Select An Activity")
                }
                .pickerStyle(DefaultPickerStyle())
                .onReceive(Just(selectedFootPrint)) { value in
                    if let newValue = logActivities[value] {
                        carbonFootprint = newValue
                    }
                }
                Text("\(carbonFootprint)")
            }
            
            TextField("Add Notes", text: $notes, axis: .vertical)
                .font(.headline)
                .padding()
            
            Button {
                if activity == "" && carbonFootprint == 0 {
                    isAlertPresent.toggle()
                } else if !alertShownOnce || !(carbonLogManager.carbonLogs.contains(where: { $0.date.isSameDay(as: currentDate) })) || currentDate.isSameDay(as: Date()) {
                    print("TRUE: \(currentDate.isSameDay(as: Date()))")
                    print("THIRD HERE \(currentDate)")
                    let carbonLog = CarbonLog(name: [activity], footprint: [carbonFootprint], notes: [notes], date: currentDate, totalFootPrint: 0.0)
                    print("HSAHHAHAHAHAH")
                    print(carbonLog)
                    carbonLogManager.carbonLogs.append(carbonLog)
                    print("HEHEHHEHAW")
                    print(carbonLogManager.carbonLogs)
                    alertShownOnce = true
                    dismiss()
                } else {
                    carbonLogs[logIndex].name.append(activity)
                    carbonLogs[logIndex].footprint.append(carbonFootprint)
                    carbonLogs[logIndex].notes.append(notes)
                    print("ELSE LOOP WORKING")
                    print(alertShownOnce)
                    print(carbonLogManager.carbonLogs)
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
        .onAppear {
            print("OTHER HERE \(currentDate)")
        }
    }
}



/*
VStack {
    Picker(selection: $selectedText) {
        ForEach(Array(logActivities.keys), id: \.self) { key in
            Text(key).tag(key)
        }
    } label: {
        Text("Select A Topic")
    }
    .pickerStyle(DefaultPickerStyle())
    
    Picker(selection: $selectedOption) {
        ForEach(Array(logActivities[selectedText]?.keys.sorted() ?? []), id: \.self) { value in
            Text(value).tag(value)
        }
    } label: {
        Text("Select An Activity")
    }
    .pickerStyle(DefaultPickerStyle())
}
.onReceive(Just(selectedOption)) { subValue in
    if let nestedDict = logActivities[selectedText], let newValue = nestedDict[subValue] {
        carbonFootprint = newValue
        print("HEREEEE")
        print(carbonFootprint)
    }
}
*/
