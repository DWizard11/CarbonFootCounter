//
//  LogManager.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import Foundation

struct CarbonLog: Identifiable, Codable {
    var id = UUID()
    var name: [String]
    var footprint: [Int]
    var notes: [String]
    var date: Date
}

class CarbonLogManager: ObservableObject {
    @Published var carbonLogs: [CarbonLog] = [] {
        didSet {
            save()
        }
    }
    
    let sampleCarbonLogs: [CarbonLog] = []
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "carbonLogs.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedCarbonLogs = try? propertyListEncoder.encode(carbonLogs)
        try? encodedCarbonLogs?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalCarbonLogs: [CarbonLog]!
        
        if let retrievedCarbonLogData = try? Data(contentsOf: archiveURL),
            let decodedCarbonLogs = try? propertyListDecoder.decode([CarbonLog].self, from: retrievedCarbonLogData) {
            finalCarbonLogs = decodedCarbonLogs
        } else {
            finalCarbonLogs = sampleCarbonLogs
        }
        
        carbonLogs = finalCarbonLogs
    }
}
