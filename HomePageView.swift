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
    
    @ObservedObject var carbonLogManager: CarbonLogManager
    @State var isSheetPresented = false
    @State var currentDate = Date()
    @State var logIndex = Int()
    @State var subSubIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach($carbonLogManager.carbonLogs.indices, id: \.self) { carbonLogIndex in
                    ForEach(carbonLogManager.carbonLogs[carbonLogIndex].name.indices, id: \.self) { subIndex in
                        NavigationLink {
                            LogView(carbonLog: $carbonLogManager.carbonLogs, logIndex: carbonLogIndex, carbonLogManager: carbonLogManager)
                        } label: {
                            Text("\(carbonLogManager.carbonLogs[carbonLogIndex].name[subIndex])")
                            

                        }
                        .onAppear {
                            subSubIndex = subIndex
                        }
                    }
                    .onAppear {
                        logIndex = carbonLogIndex
                    }
                }
                
                .onDelete { indexSet in
                    carbonLogManager.carbonLogs.remove(atOffsets: indexSet)
                }
                .onMove { originalOffset, newOffset in
                    carbonLogManager.carbonLogs.move(fromOffsets: originalOffset, toOffset: newOffset)
                }
                
                NavigationLink {
                    EndDayView(carbonLogManager: carbonLogManager, carbonLog: carbonLogManager.carbonLogs)
                } label: {
                    Text("End Day")
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
                .sheet(isPresented: $isSheetPresented) {
                    NewLogView(carbonLogManager: carbonLogManager, carbonLogs: $carbonLogManager.carbonLogs, logIndex: logIndex, currentDate: Date())
                }
                
            }
            
            
            
        }
    }
    
}
