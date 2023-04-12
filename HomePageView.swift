//
//  HomePageView.swift
//  CarbonFootPrintCalculator
//
//  Created by DWizard11 on 7/4/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomePageView: View {
    
    @ObservedObject var carbonLogManager: CarbonLogManager
    @State var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($carbonLogManager.carbonLogs) { $carbonLog in
                        NavigationLink {
                            LogView(carbonLog: $carbonLog, carbonLogManager: carbonLogManager)
                        } label: {
                            Text(carbonLog.name)
                                .font(.headline)
                                .padding()
                            
                        }
                        
                    }
                    .onDelete { indexSet in
                        carbonLogManager.carbonLogs.remove(atOffsets: indexSet)
                    }
                    .onMove { originalOffset, newOffset in
                        carbonLogManager.carbonLogs.move(fromOffsets: originalOffset, toOffset: newOffset)
                    }
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
            .sheet(isPresented: $isSheetPresented) {
                NewLogView(carbonLogs: $carbonLogManager.carbonLogs)
            }

        }
        
        
        
    }
}

