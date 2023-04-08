//
//  NewLogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 8/4/23.
//

import SwiftUI

struct NewLogView: View {
    
    @State var activity = ""
    @State var typeOfActivity = ""
    
    var body: some View {
        VStack {
            TextField("Activity", text: $activity)
                .font(.headline)
            TextField("Type of Activity", text: $typeOfActivity)
        }
    }
}

struct NewLogView_Previews: PreviewProvider {
    static var previews: some View {
        NewLogView()
    }
}
