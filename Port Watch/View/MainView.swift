//
//  MainView.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.openWindow) private var openWindow
    @StateObject private var model = MainViewModel()
    @State private var sortOrder = [KeyPathComparator<NetworkConnection>]()
    @State private var selection = Set<NetworkConnection.ID>()
    @State private var search = ""
    @Binding var selectedConnections: [NetworkConnection]
    private var connections: [NetworkConnection] {
        model.connections.filter { search.isEmpty || $0.processName.lowercased().contains(search.lowercased()) }.sorted(using: sortOrder)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Table(connections, selection: $selection, sortOrder: $sortOrder) {
                TableColumn(Constants.connectionName, value: \.processName, content: ProcessNameColumn.init)
                TableColumn(Constants.connectionPid, value: \.processId)
                TableColumn(Constants.connectionProtocol, value: \.networkProtocol.rawValue)
                TableColumn(Constants.localAddress, value: \.localAddress.ip)
                TableColumn(Constants.localPort, value: \.localAddress.port)
                TableColumn(Constants.remoteAddress, value: \.remoteAddress.ip)
                TableColumn(Constants.remotePort, value: \.remoteAddress.port)
                TableColumn(Constants.connectionState, value: \.connectionState)
            }
            .contextMenu(forSelectionType: NetworkConnection.ID.self) { selectedIds in
                Button {
                    selectedConnections.append(contentsOf: connections.filter { selectedIds.contains($0.id) })
                    selectedIds.forEach { openWindow(value: $0) }
                } label: {
                    Label("Info", systemImage: Constants.infoCircleFill).labelStyle(.titleAndIcon)
                }
                .disabled(selectedIds.isEmpty)
            }
            .onReceive(model.$connections) {
                selection = selection.filter($0.map(\.id).contains)
            }
            Divider()
            HStack {
                Text(Constants.mainWindowFooterInfo(connections.count, model.remoteIPs, selection.count))
                Spacer()
                Button(action: model.toggleTimer) {
                    Image(systemName: Constants.circleFill)
                        .foregroundColor(model.timerRepeats ? .green : .lightGray)
                }
                .buttonStyle(.borderless)
                .shadow(
                    color: .darkGray,
                    radius: Constants.reloadButtonShadowRadius,
                    x: Constants.reloadButtonShadowXPosition,
                    y: Constants.reloadButtonShadowYPosition)
                .help(model.timerRepeats ? Constants.refreshStop : Constants.refreshStart)
            }
            .padding(.horizontal)
            .padding(.vertical, Constants.mainWindowFooterHorizontalPadding)
        }
        .font(.mainTableFont)
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
                .frame(height: Constants.mainTableIconSize)
                .padding(.horizontal, Constants.mainTableIconPadding)
            Text(connection.processName)
                .help(Text(connection.processName))
        }
    }
}
