//
//  LogView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import SwiftUI

struct LogView: View {

    @ObservedObject var carbonLogManager: CarbonLogManager
    @Binding var carbonLog: CarbonLog
    
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
        Text("Activity: \(carbonLog.name)")
        
    }
}

