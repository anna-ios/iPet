//
//  ContentView.swift
//  iPet
//
//  Created by Zelinskaya Anna on 05.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var petViewModel: PetViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            if router.currentPage == .first {
                EditPetView(pet: Pet())
                    .environmentObject(self.petViewModel)
                    .environmentObject(self.router)
            } else if router.currentPage == .home {
                RootView()
            }
        }
    }
    
    struct RootView : View {
        @State private var tabSelection = 0
        
        var body: some View {
            TabView(selection: $tabSelection) {
                PetsListScreen().tabItem {
                    Image(systemName: "info.circle")
                    Text("Pets")
                }.tag(0)
                NotificationsListScreen().tabItem {
                    Text("Notifications")
                    Image(systemName: "list.bullet")
                }.tag(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
