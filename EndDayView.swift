//
//  EndDayView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 14/4/23.
//


import SwiftUI

@available(iOS 16.0, *)
struct EndDayView: View { 

    @ObservedObject var carbonLogManager: CarbonLogManager
    @State var carbonLog: [CarbonLog]
    @State var averageLog = 732.9
    @State var percentageLog = 0.0
    
    var logIndex: Int

    var body: some View {
        VStack {
            Text("Your total calculated Carbon Footprint of the day is \(carbonLogManager.carbonLogs[logIndex].totalFootPrint.rounded())")
                .onAppear {
                    carbonLogManager.carbonLogs[logIndex].totalFootPrint = carbonLogManager.carbonLogs[logIndex].footprint.reduce(0, { $0 + $1 })
                    percentageLog = (carbonLogManager.carbonLogs[logIndex].totalFootPrint / averageLog) * 100
                }
            Text("Compared to the Singaporean Average of \(averageLog), you have used \(carbonLogManager.carbonLogs[logIndex].totalFootPrint)")
            if carbonLogManager.carbonLogs[logIndex].totalFootPrint < averageLog {
                Text("You've used less than the Singaporean Average. Great Job!")
            } else {
                Text("You have used \(carbonLogManager.carbonLogs[logIndex].totalFootPrint - averageLog) more than the Singaporean Average.")
                Text("Some Precautions that you should take to reduce your carbon emmission: ")
            }
        }
        
        
    }
}
