//
//  Port_WatchApp.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

@main
struct Port_WatchApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State private var selectedConnections = [NetworkConnection]()
    
    var body: some Scene {
        WindowGroup {
            MainView(selectedConnections: $selectedConnections)
        }
        WindowGroup(for: NetworkConnection.ID.self) { $id in
            if let connection = selectedConnections.first { $0.id == id } {
                DetailView(for: connection)
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
    }
}
