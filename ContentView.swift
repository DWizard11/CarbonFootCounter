import SwiftUI

@available(iOS 16.0, *)
struct ContentView: View {
    
    @StateObject var carbonLogManager = CarbonLogManager()
    
    var body: some View {
        TabView {
            HomePageView(carbonLogManager: carbonLogManager)
                .tabItem {
                    Label("Logs", systemImage: "newspaper.fill")
                }
            SummaryView(carbonLogManager: carbonLogManager)
                .tabItem {
                    Label("Help", systemImage: "globe")
                }
        }
    }
}
