//
//  HomePageView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import SwiftUI
import Foundation

@available(iOS 16.0, *)
struct HomePageView: View {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    @ObservedObject var carbonLogManager: CarbonLogManager
    @State var isSheetPresented = false
    @State var logIndex = Int()
    @State var subSubIndex = Int()
    @State var currentDate = Date()
    @State var isEndSheetPresented = false
    @State var carbonLogIndex = 0
    var isTrue = true
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                    } label: {
                        Text("< Previous Day")
                            .padding()
                    }
                    Spacer()
                    Text("Today is \(dateFormatter.string(from: currentDate))")
                    Spacer()
                    Button {
                        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                        print(currentDate)
                    } label: {
                        Text("Next Day >")
                            .padding()
                        
                    }
                }
                List {
                    ForEach (carbonLogManager.carbonLogs.filter({ $0.date.isSameDay(as: currentDate) })) { log in
                        ForEach(carbonLogManager.carbonLogs[carbonLogManager.carbonLogs.firstIndex(of: log)!].name.indices, id: \.self) { subIndex in
                            NavigationLink {
                                LogView(carbonLog: $carbonLogManager.carbonLogs, logIndex: carbonLogManager.carbonLogs.firstIndex(of: log)!, subIndex: subIndex, carbonLogManager: carbonLogManager)
                            } label: {
                                Text("\(carbonLogManager.carbonLogs[carbonLogManager.carbonLogs.firstIndex(of: log)!].name[subIndex])")
                                    .padding()
                                    .onAppear {
                                        self.logIndex = carbonLogManager.carbonLogs.firstIndex(of: log)!
                                        print(carbonLogManager.carbonLogs.firstIndex(of: log)!)
                                        
                                    }
                            }
                            .padding()
                        }
                        .onAppear {
                            print(carbonLogManager.carbonLogs)
                            print(logIndex)
                            print("DATES")
                            print(currentDate)
                            print(carbonLogManager.carbonLogs[carbonLogIndex].date)
                            
                        }
                        
                   
                        
                    }
                    .onDelete { indexSet in
                        carbonLogManager.carbonLogs[logIndex].name.remove(atOffsets: indexSet)
                        carbonLogManager.carbonLogs[logIndex].footprint.remove(atOffsets: indexSet)
                        carbonLogManager.carbonLogs[logIndex].notes.remove(atOffsets: indexSet)
                        
                    }
                    .onMove { originalOffset, newOffset in
                        carbonLogManager.carbonLogs[logIndex].name.move(fromOffsets: originalOffset, toOffset: newOffset)
                        carbonLogManager.carbonLogs[logIndex].footprint.move(fromOffsets: originalOffset, toOffset: newOffset)
                        carbonLogManager.carbonLogs[logIndex].notes.move(fromOffsets: originalOffset, toOffset: newOffset)
                        
                    }
                    
                    
                }
                
                
                Button {
                    isEndSheetPresented.toggle()
                } label : {
                    Text("End Day")
                        .padding()
                }
            }
            Divider()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button  {
                            isSheetPresented.toggle()
                            print(currentDate)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            
            
                .sheet(isPresented: $isSheetPresented) {
                    NewLogView(carbonLogManager: carbonLogManager, carbonLogs: $carbonLogManager.carbonLogs, logIndex: logIndex, currentDate: currentDate)
                        .onAppear {
                            print("HERE \(currentDate)")
                        }
                }
                .sheet(isPresented: $isEndSheetPresented) {
                    EndDayView(carbonLogManager: carbonLogManager, carbonLog: carbonLogManager.carbonLogs, logIndex: logIndex)
                }
            
            
        }
        
        
        
    }
}


extension Date {
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


extension CarbonLog: Equatable {
    static func == (lhs: CarbonLog, rhs: CarbonLog) -> Bool {
        return lhs.date == rhs.date
    }
}
//                         carbonLogIndex = carbonLogManager.carbonLogs.enumerated().first(where: { $0.element == log })!.offset

