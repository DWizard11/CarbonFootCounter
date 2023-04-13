//
//  EndDayView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 14/4/23.
//


import SwiftUI

@available(iOS 16.0, *)
struct EndDayView: View { 

    @ObservabedObject var carbonFootManager: CarbonFootManager()
    @State var carbonLog: CarbonLog

    var body: some View {

        NavigationStack { 
             Text(carbonFootManager.carbonLogs)
        }
        .navigationTitle("Summary")
    }
}