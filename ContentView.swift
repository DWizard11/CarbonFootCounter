import SwiftUI

struct ContentView: View {
    
    @StateObject var carbonLogManager = CarbonLogManager()
    
    var body: some View {
        TabView {
            HomePageView()
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
