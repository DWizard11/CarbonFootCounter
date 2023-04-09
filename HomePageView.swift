//
//  HomePageView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import SwiftUI

struct HomePageView: View {
    
    @ObservedObject var carbonLogManager: CarbonLogManager
    @State var isSheetPresented = false
    
    var body: some View {
        VStack {
            ForEach($carbonLogManager.carbonLogs) { $carbonLog in
                NavigationLink {
                    LogView(carbonLog: $carbonLog, carbonLogManager: carbonLogManager)
                } label: {
                    Text(carbonLog.name)
                }
                
            }
            Button {
                isSheetPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }

        }
        .sheet(isPresented: $isSheetPresented) {
            NewLogView(carbonLogManager: carbonLogManager)
        }
    }
}

