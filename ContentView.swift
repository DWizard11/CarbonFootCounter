import SwiftUI

@available(iOS 16.0, *)
struct ContentView: View {
    
    @StateObject var carbonLogManager = CarbonLogManager()
    
    var body: some View {
        TabView {
            HomePageView(carbonLogManager: carbonLogManager)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SummaryView()
                .tabItem {
                    Label("Summary", systemImage: "globe")
                }
        }
    }
}
