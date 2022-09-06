//
//  ConnectionsUtil.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import Foundation
import os

final class ConnectionsUtil {
    
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ConnectionsUtil.self)
    )
    
    private init() {}
    
    static func fetchConnections(netStatProcess: Process = Process(), grepProcess: Process = Process(), pipe: Pipe = Pipe(), outPipe: Pipe = Pipe(), connections: inout [NetworkConnection]) {
        do {
            netStatProcess.launchPath = "/usr/sbin/netstat"
            netStatProcess.arguments = ["-nvAWl"]
            netStatProcess.standardOutput = pipe
            
            grepProcess.launchPath = "/usr/bin/egrep"
            grepProcess.arguments = ["^(\\w+\\s+){2}(udp|tcp)"]
            grepProcess.standardInput = pipe
            grepProcess.standardOutput = outPipe

            try netStatProcess.run()
            try grepProcess.run()
            
            let data = outPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(decoding: data, as: UTF8.self)
            let lines = output.split(whereSeparator: \.isNewline).map(String.init)
            connections = lines.map(NetworkConnection.init)
        } catch let error {
            Self.logger.debug("Error fetching connections:\n\(String(describing: error))")
        }
    }
}
