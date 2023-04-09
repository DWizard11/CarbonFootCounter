import SwiftUI

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
