//
//  NetworkConnection.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

struct NetworkConnection: Identifiable, Hashable {
    
    let id: String
    let networkProtocol: NetworkProtocol
    let localAddress: NetworkAddress
    let remoteAddress: NetworkAddress
    let connectionState: String
    let processId: String
    let processName: String
    let image: Image
    
    init(using input: String) {
        let strings = input.split(omittingEmptySubsequences: true, whereSeparator: \.isWhitespace).map(String.init)
        let local = strings[5].replacingOccurrences(of: "%\\w+.", with: ".", options: .regularExpression)
        let remote = strings[6].replacingOccurrences(of: "%\\w+.", with: ".", options: .regularExpression)
        id = strings[0] + strings[1]
        networkProtocol = NetworkProtocol(using: strings[2])
        localAddress = NetworkAddress(using: local)
        remoteAddress = NetworkAddress(using: remote)
        connectionState = networkProtocol.rawValue.hasPrefix("tcp") ? strings[7] : "-"
        processId = strings[strings.count - 4]
        processName = ResourceUtil.processName(for: processId)
        image = ResourceUtil.icon(for: processId)
    }
    
    static func == (lhs: NetworkConnection, rhs: NetworkConnection) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
