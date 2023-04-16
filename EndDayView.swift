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
    var logIndex: Int

    var body: some View {
        Text("Your total calculated Carbon Footprint of the day is \(carbonLogManager.carbonLogs[logIndex].totalFootPrint)")
            .onAppear {
                carbonLogManager.carbonLogs[logIndex].totalFootPrint = carbonLogManager.carbonLogs[logIndex].footprint.reduce(0, { $0 + $1 })
            }
    }
}
