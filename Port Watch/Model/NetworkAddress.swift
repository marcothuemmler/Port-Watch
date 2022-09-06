//
//  NetworkAddress.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

struct NetworkAddress {
    
    let ip: String
    let port: String
    
    init(using string: String) {
        let index = string.lastIndex(of: ".")
        ip = String(string[..<index!])
        port = String(string[index!...].dropFirst())
    }
}
