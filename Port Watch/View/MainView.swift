//
//  MainView.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var model = MainViewModel()
    @State private var sortOrder = [KeyPathComparator<NetworkConnection>]()
    @State private var selection = Set<NetworkConnection.ID>()
    @State private var search = ""
    private var connections: [NetworkConnection] {
        model.connections.filter { search.isEmpty || $0.processName.lowercased().contains(search.lowercased()) }.sorted(using: sortOrder)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Table(connections, selection: $selection, sortOrder: $sortOrder) {
                TableColumn("connection.name", value: \.processName, content: ProcessNameColumn.init)
                TableColumn("connection.pid", value: \.processId)
                TableColumn("connection.protocol", value: \.networkProtocol.rawValue)
                TableColumn("connection.localAddress", value: \.localAddress.ip)
                TableColumn("connection.localPort", value: \.localAddress.port)
                TableColumn("connection.remoteAddress", value: \.remoteAddress.ip)
                TableColumn("connection.remotePort", value: \.remoteAddress.port)
                TableColumn("connection.state", value: \.connectionState)
            }
            .contextMenu(forSelectionType: NetworkConnection.ID.self) { selectedIds in
                let selectedConnections = connections.filter { selectedIds.contains($0.id) }
                Button {
                    for connection in selectedConnections {
                        let alert = NSAlert()
                        alert.messageText = connection.processName
                        alert.informativeText = connection.processId
                        alert.icon = ResourceUtil.nsImage(for: connection.processId)
                        alert.runModal()
                    }
                } label: {
                    Label("Info", systemImage: "info.circle.fill").labelStyle(.titleAndIcon)
                }
                .disabled(selectedConnections.isEmpty)
                
            }
            .onReceive(model.$connections) {
                selection = selection.filter($0.map(\.id).contains)
            }
            Divider()
            HStack {
                Text("\(connections.count) open ports \(model.remoteIPs) connections \(selection.count) selected")
                Spacer()
                Button(action: model.toggleTimer) {
                    Image(systemName: "circle.fill")
                        .foregroundColor(model.timerRepeats ? .green : Color(.lightGray))
                }
                .buttonStyle(.borderless)
                .shadow(color: Color(.darkGray), radius: 0.6, x: 0.3, y: 0.3)
                .help(model.timerRepeats ? "refresh.stop" : "refresh.start")
            }
            .padding(.horizontal)
            .padding(.vertical, 5.0)
        }
        .font(Font(CTFont(.label, size: 12)))
        .frame(minWidth: 500, idealWidth: 800, minHeight: 500, idealHeight: 600)
        .searchable(text: $search)
    }
}

private struct ProcessNameColumn: View {
    
    fileprivate let connection: NetworkConnection
    
    var body: some View {
        HStack {
            connection.image
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(.horizontal, 10)
            Text(connection.processName)
                .help(Text(connection.processName))
        }
    }
}
