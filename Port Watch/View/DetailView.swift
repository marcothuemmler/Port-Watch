//
//  DetailView.swift
//  Port Watch
//
//  Created by Marco Thümmler on 04.11.22.
//

import SwiftUI

struct DetailView: View {
    
    private let connection: NetworkConnection
    
    init(for connection: NetworkConnection) {
        self.connection = connection
    }
    
    var body: some View {
        VStack(spacing: 2) {
            connection.image
                .resizable()
                .frame(width: Constants.detailViewIconSize, height: Constants.detailViewIconSize)
                .padding(.bottom, Constants.detailViewVerticalPadding)
            InformationRow(Constants.connectionName, value: connection.processName)
            InformationRow(Constants.connectionPid, value: connection.processId)
            InformationRow(Constants.connectionProtocol, value: connection.networkProtocol.rawValue)
            InformationRow(Constants.connectionState, value: connection.connectionState)
        }
        .padding(.vertical, Constants.detailViewVerticalPadding)
        .frame(width: Constants.detailWindowWidth, height: Constants.detailWindowHeight)
        .background(VisualEffectView().ignoresSafeArea())
    }
    
    private struct InformationRow: View {
        
        let title: LocalizedStringKey
        let value: String
        
        init(_ title: LocalizedStringKey, value: String) {
            self.title = title
            self.value = value
        }
        
        var body: some View {
            HStack(spacing: 0) {
                Text(title).bold()
                Text(":").bold()
                Spacer()
                Text(value)
            }
            .padding(.horizontal, Constants.detailViewHorizontalPadding)
        }
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.state = .active
        return effectView
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
    }
}
