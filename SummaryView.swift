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
    @State var precautions = [
        "Switch off the lights when not in use",
        "Keep air-conditioner at higher temperatures, or just use a fan",
        "Limit the use of air travel",
        "Unplug appliances that are not in use",
        "Turn off electrical devices when not in use",
        "Take shorter showers",
        "Take the public transport or consider walking instead of using a car",
        "Use LED Lights instead",
        "Air-dry your clothes instead of using a clothes dryer",
        "Make use of natural light as much as possible"
    ]
    let mainColor = UIColor(red: 58, green: 124, blue: 85)
    let otherColor = UIColor(red: 67, green: 142, blue: 119)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(otherColor)
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Text("How to Reduce Carbon Footprint: ")
                        .padding()
                        .font(.title)
                    VStack {
                        List {
                            ForEach(precautions, id: \.self) { precaution in
                                Text(precaution)
                                    .padding()
                            }
                            .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                            .shadow(radius: 0.1)
                        }
                        .listStyle(.insetGrouped)
                        .padding()
                        
                        
                    }
                }
            }
        }
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
