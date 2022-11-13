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
        .commands { CommandGroup(replacing: .newItem) { } }
            .defaultSize(width: Constants.mainWindowDefaultWidth, height: Constants.mainWindowDefaultHeight)
        WindowGroup(for: NetworkConnection.ID.self) { $id in
            if let connection = selectedConnections.first { $0.id == id } {
                DetailView(for: connection)
                    .onDisappear { selectedConnections.removeAll { $0.id == id } }
            }
        }
        .defaultPosition(.center)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
