//
//  Port_WatchApp.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

@main
struct Port_WatchApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
