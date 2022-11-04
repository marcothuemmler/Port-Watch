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
                .frame(width: Constants.detailsIconSize, height: Constants.detailsIconSize)
                .padding(.bottom, Constants.detailViewIconBottomPadding)
            InformationRow("connection.name", value: connection.processName)
            InformationRow("connection.pid", value: connection.processId)
            InformationRow("connection.protocol", value: connection.networkProtocol.rawValue)
            InformationRow("connection.state", value: connection.connectionState)
        }
        .padding(.horizontal, Constants.detailViewHorizontalPadding)
        .frame(width: Constants.detailWindowWidth, height: Constants.detailWindowHeight)
        .background(VisualEffectView().ignoresSafeArea())
    }
    
    private struct InformationRow: View {
        
        let title: LocalizedStringKey
        let value: String
        
        init(_ title: String, value: String) {
            self.title = LocalizedStringKey(title)
            self.value = value
        }
        
        var body: some View {
            HStack(spacing: 0) {
                Text(title).bold()
                Text(":").bold()
                Spacer()
                Text(value)
            }
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
