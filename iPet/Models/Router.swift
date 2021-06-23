//
//  Router.swift
//  iPet
//
//  Created by Zelinskaya Anna on 05.05.2021.
//

import Foundation

import SwiftUI

class Router: ObservableObject {
    
    enum CurrentPageState {
        case first, home
    }
    
    @Published var currentPage: CurrentPageState
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = .first
        } else {
            currentPage = .home
        }
    }
}
