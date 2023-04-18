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
    @State var precautions = [
        "Switch off the Lights when not in use",
        "Keep Air-Conditioner at Low Temperatures",
        "Lower the amount of Plugs in one socket",
    ]
    let mainColor = UIColor(red: 58, green: 124, blue: 85)
    let otherColor = UIColor(red: 67, green: 142, blue: 119)
    @Environment(\.dismiss) var dismiss
    
    var logIndex: Int
    
    var body: some View {
        VStack {
            Text("Your total calculated Carbon Footprint of the day is \(carbonLogManager.carbonLogs[logIndex].totalFootPrint.removeZerosFromEnd()) kg ")
                .onAppear {
                    carbonLogManager.carbonLogs[logIndex].totalFootPrint = carbonLogManager.carbonLogs[logIndex].footprint.reduce(0, { $0 + $1 })
                    percentageLog = (carbonLogManager.carbonLogs[logIndex].totalFootPrint / averageLog) * 100
                }
            Text("Compared to the Singaporean Average of \(averageLog.removeZerosFromEnd()) kg, you have used \(carbonLogManager.carbonLogs[logIndex].totalFootPrint.removeZerosFromEnd())")
            if carbonLogManager.carbonLogs[logIndex].totalFootPrint < averageLog {
                Text("You've used less than the Singaporean Average. Great Job!")
            } else {
                Text("You have used \((carbonLogManager.carbonLogs[logIndex].totalFootPrint - averageLog).removeZerosFromEnd()) kg more than the Singaporean Average.")
            }
            Text("Precautions that you should take to reduce your carbon emmission: ")
                .padding()
                .font(.title)
            VStack {
                ForEach(precautions, id: \.self) { precaution in
                    Text(precaution.capitalized)
                        
                }
            }
            
            Button {
                dismiss()
            } label: {
                Text("Dismiss Day")
                    .padding()
                    .background(Color(otherColor))
                    .cornerRadius(12)
            }
            .padding()
        }
        
        
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
/*
 Switch it Off
 Turn off the lights when natural light is sufficient and when you leave the room. It’s that simple!
 
 Climate Control
 Keep your temperature system on a moderate setting while you’re in the room.
 
 Wasteful Windows
 Use your windows wisely! If your climate control system is on, shut them…if you need a little fresh air, turn off the heat or AC.
 
 Minimize Plug Load
 Cut down the number of appliances you are running and you will save big on energy. For example, share your minifridge with roomates and minimize the number of printers in your office.
 
 Phantom Power
 Did you know that many electronics continue using energy even when powered down? This is true of any charger, television, printer, etc. Use a power strip to easily unplug these electronics when not in use.
 
 Give it a Rest
 Power your computer down when you’re away. A computer turned off uses at least 65% less energy than a computer left on or idle on a screen saver.
 
 Take the Stairs
 Use the stairs as often as possible. Elevators consume electricity. You, on the other hand, do not.
 
 Loaded Laundry
 Only do full loads of laundry and use the bright colors cycle whenever possible.
 
 Shorter Showers
 Try to take shorter showers. The less hot water you use, the less energy is needed to heat the water.
 
 Switch to CFLs
 Compact fluorescent light bulbs (CFLs) use 75% less energy than incandescent and last up to 10 times longer.
 */
