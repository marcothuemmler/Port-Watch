//
//  MainView.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var model = MainViewModel()
    @State private var sortOrder = [KeyPathComparator<NetworkConnection>]()
    @State private var selection = Set<NetworkConnection.ID>()
    
    var body: some View {
        VStack(spacing: 0) {
            Table(model.connections.sorted(using: sortOrder), selection: $selection, sortOrder: $sortOrder) {
                TableColumn("connection.name", value: \.processName, content: ProcessNameColumn.init)
                TableColumn("connection.pid", value: \.processId)
                TableColumn("connection.protocol", value: \.networkProtocol.rawValue)
                TableColumn("connection.localAddress", value: \.localAddress.ip)
                TableColumn("connection.localPort", value: \.localAddress.port)
                TableColumn("connection.remoteAddress", value: \.remoteAddress.ip)
                TableColumn("connection.remotePort", value: \.remoteAddress.port)
                TableColumn("connection.state", value: \.connectionState)
            }
            .onChange(of: selection) {
                selection = $0.filter(model.connections.map(\.id).contains)
            }
            Divider()
            HStack {
                Text("\(model.connections.count) open ports \(model.remoteIPs) connections \(selection.count) selected")
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
        .frame(minWidth: 500, idealWidth: 800, minHeight: 500, idealHeight: 600)
    }
}

private struct ProcessNameColumn: View {
    
    fileprivate let connection: NetworkConnection
    
    var body: some View {
        HStack {
            connection.image
                .resizable()
                .scaledToFit()
            Text(connection.processName)
                .help(Text(connection.processName))
        }
    }
}
