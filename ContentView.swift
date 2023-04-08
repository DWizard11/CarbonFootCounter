import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}
