//
//  Constants.swift
//  Port Watch
//
//  Created by Marco Thümmler on 04.11.22.
//

import Foundation
import SwiftUI

struct Constants {
    
    // MARK: - CGFloat Constants
    static let mainWindowDefaultHeight: CGFloat = 560
    static let mainWindowDefaultWidth: CGFloat = 900
    static let mainWindowFooterHorizontalPadding: CGFloat = 5
    
    static let reloadButtonShadowRadius: CGFloat = 0.6
    static let reloadButtonShadowXPosition: CGFloat = 0.3
    static let reloadButtonShadowYPosition: CGFloat = 0.3
    
    static let detailViewHorizontalPadding: CGFloat = 30
    static let detailViewVerticalPadding: CGFloat = 30
    static let detailViewIconSize: CGFloat = 128
    static let detailWindowWidth: CGFloat = 350
    static let detailWindowHeight: CGFloat = 280
    
    static let mainTableIconSize: CGFloat = 18
    static let mainTableIconPadding: CGFloat = 10
    
    // MARK: - Icon Strings
    static let infoCircleFill: String = "info.circle.fill"
    static let circleFill: String = "circle.fill"
    
    // MARK: - Localized String Keys
    static let refreshStop: LocalizedStringKey = "refresh.stop"
    static let refreshStart: LocalizedStringKey = "refresh.start"
    static let connectionName: LocalizedStringKey = "connection.name"
    static let connectionPid: LocalizedStringKey = "connection.pid"
    static let connectionProtocol: LocalizedStringKey = "connection.protocol"
    static let localAddress: LocalizedStringKey = "connection.localAddress"
    static let localPort: LocalizedStringKey = "connection.localPort"
    static let remoteAddress: LocalizedStringKey = "connection.remoteAddress"
    static let remotePort: LocalizedStringKey = "connection.remotePort"
    static let connectionState: LocalizedStringKey = "connection.state"
    static let mainWindowFooterInfo: (Int, Int, Int) -> LocalizedStringKey = {
        "\($0) open ports \($1) connections \($2) selected"
    }
}

extension Color {
    static let lightGray = Self(.lightGray)
    static let darkGray = Self(.darkGray)
}

extension Font {
    static let mainTableFont = Self(CTFont(.label, size: 12))
}
