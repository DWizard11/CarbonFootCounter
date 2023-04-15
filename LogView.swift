//
//  LogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct LogView: View {

    @Binding var carbonLog: [CarbonLog]
    var logIndex: Int
    var subIndex: Int
    @ObservedObject var carbonLogManager: CarbonLogManager
    @State var notes = ""
    @FocusState var notesIsFocused: Bool
    
    
    var body: some View {
        Form {
            VStack (alignment: .leading) {
                Text("Activity: \(carbonLog[logIndex].name[subIndex])")
                    .font(.title)
                    .bold()
                    .padding()
                Text("Carbon Footprint: \(carbonLog[logIndex].footprint[subIndex])")
                    .padding()
                HStack {
                    TextField("Add Notes", text: $carbonLog[logIndex].notes[subIndex], axis: .vertical)
                        .focused($notesIsFocused)
                        .font(.headline)
                        .padding()
                        
                    Button("Done") {
                        notesIsFocused = false
                    }
                }
            }
        }
        
        Spacer()
    }
}

