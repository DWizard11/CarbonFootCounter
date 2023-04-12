//
//  LogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import SwiftUI

struct LogView: View {

    @Binding var carbonLog: CarbonLog
    @ObservedObject var carbonLogManager: CarbonLogManager
    
    var log: CarbonLog {
        get {
            let carbonLogIndex = self.carbonLogManager.carbonLogs.firstIndex {
                $0.id == carbonLog.id
            }!
            
            return self.carbonLogManager.carbonLogs[carbonLogIndex]
        }
        set {
            let carbonLogIndex = self.carbonLogManager.carbonLogs.firstIndex {
                $0.id == carbonLog.id
            }!
            self.carbonLogManager.carbonLogs[carbonLogIndex] = newValue
        }
    }
    
    func setLog(log: CarbonLog) {
        let carbonLogIndex = self.carbonLogManager.carbonLogs.firstIndex {
            $0.id == carbonLog.id
        }!
        self.carbonLogManager.carbonLogs[carbonLogIndex] = log
    }
    
    var body: some View {
        VStack {
            Text("Activity: \(carbonLog.name)")

        }
        
    }
}

