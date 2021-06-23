//
//  iPetApp.swift
//  iPet
//
//  Created by Zelinskaya Anna on 05.05.2021.
//

import SwiftUI

@main
struct iPetApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        ServiceLocator.shared.addService(service: (PageLoadingService() as PageLoadingService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
                .environmentObject(PetViewModel())
                .environmentObject(NotificationsViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
