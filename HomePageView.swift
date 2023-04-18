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
    @State var searchText = ""
    var isTrue = true
    let mainColor = UIColor(red: 58, green: 124, blue: 85)
    let otherColor = UIColor(red: 67, green: 142, blue: 119)
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                        print("HERE HERE")
                        print(currentDate)
                    } label: {
                        Text("< Previous Day")
                            .padding()
                    }
                    Spacer()
                    Text("Current Date: \(dateFormatter.string(from: currentDate))")
                    Spacer()
                    Button {
                        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                        print(currentDate)
                    } label: {
                        Text("Next Day >")
                           
                        
                    }
                }
                .background(Color(otherColor))
                TextField(text: $searchText) {
                    Text("Search")
                        .padding(.horizontal)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                List {
                    ForEach (carbonLogManager.carbonLogs.filter({ $0.date.isSameDay(as: currentDate) })) { log in
                        ForEach(carbonLogManager.carbonLogs[carbonLogManager.carbonLogs.firstIndex(of: log)!].name.indices, id: \.self) { subIndex in
                            if searchText.isEmpty ? true : "\(log)".lowercased().contains(self.searchText.lowercased()) {
                                NavigationLink {
                                LogView(carbonLog: $carbonLogManager.carbonLogs, logIndex: carbonLogManager.carbonLogs.firstIndex(of: log)!, subIndex: subIndex, carbonLogManager: carbonLogManager)
                            } label: {
                                Text("\(carbonLogManager.carbonLogs[carbonLogManager.carbonLogs.firstIndex(of: log)!].name[subIndex])")
                                    .padding()
                                    .onAppear {
                                        self.logIndex = carbonLogManager.carbonLogs.firstIndex(of: log)!
                                        print("HHHHHH")
                                        print(currentDate)
                                        
                                    }
                            }
                            .padding(.horizontal)
                        }
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
                    .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    .shadow(radius: 0.1)
                    
                    
                }
                .listStyle(.insetGrouped)
                .onAppear {
                    print(currentDate)
                }
                
                
                Button {
                    isEndSheetPresented.toggle()
                } label : {
                    Text("End Day")
                        .padding()
                        .background(Color(otherColor))
                        .cornerRadius(10)
                }
                .padding()
            }
            
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
        .onAppear {
            print("ON LAUNCH \(currentDate)")
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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
