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
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Today is \(dateFormatter.string(from: currentDate))")
                    List {
                        ForEach (carbonLogManager.carbonLogs.filter({ $0.date.isSameDay(as: currentDate) })) { log in
                            ForEach($carbonLogManager.carbonLogs.indices, id: \.self) { carbonLogIndex in
                                ForEach(carbonLogManager.carbonLogs[carbonLogIndex].name.indices, id: \.self) { subIndex in
                                    NavigationLink {
                                        LogView(carbonLog: $carbonLogManager.carbonLogs, logIndex: carbonLogIndex, subIndex: subIndex, carbonLogManager: carbonLogManager)
                                    } label: {
                                        Text("\(carbonLogManager.carbonLogs[carbonLogIndex].name[subIndex])")
                                            .padding()
                                            .onTapGesture {
                                                self.logIndex = logIndex
                                            }
                                    }
                                }
                                .onAppear {
                                    print(carbonLogManager.carbonLogs)
                                    print(logIndex)
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
                        
                    }
                    Button("Next Day") {
                        currentDate = currentDate.addingTimeInterval(86400)
                    }
                    Button("Previous Day") {
                        currentDate = currentDate.addingTimeInterval(-86400)
                    }
                    NavigationLink {
                        EndDayView(carbonLogManager: carbonLogManager, carbonLog: carbonLogManager.carbonLogs)
                    } label: {
                        Text("End Day")
                    }
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button  {
                            isSheetPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }

            }
            .sheet(isPresented: $isSheetPresented) {
                NewLogView(carbonLogManager: carbonLogManager, carbonLogs: $carbonLogManager.carbonLogs, logIndex: logIndex, currentDate: currentDate)
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

    
