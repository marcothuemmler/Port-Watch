//
//  NetworkProtocol.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

enum NetworkProtocol: String, Comparable {
    
    case tcp4 = "tcp4"
    case tcp6 = "tcp6"
    case udp4 = "udp4"
    case udp6 = "udp6"
    case udp46 = "udp46"
    case other
    
    init(using value: String) {
        self = NetworkProtocol(rawValue: value) ?? .other
    }
    
    static func < (lhs: NetworkProtocol, rhs: NetworkProtocol) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
