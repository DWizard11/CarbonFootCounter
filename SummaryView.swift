//
//  SummaryView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 8/4/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct SummaryView: View {

    @ObservedObject var carbonLogManager: CarbonLogManager

    var body: some View {   
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("Summary")
    }
}
