//
//  MainViewModel.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var connections = [NetworkConnection]()
    @Published var timeInterval: Double = 2.0
    @Published var timerRepeats: Bool = true
    @Published var remoteIPs: Int = 0
    private var timer = Timer()
    
    init() {
        startTimer()
    }
    
    @objc private func fetchConnections() -> Void {
        ConnectionsUtil.fetchConnections(connections: &connections)
        remoteIPs = Set(connections.filter { $0.remoteAddress.ip != "*" }.map(\.remoteAddress.ip)).count
    }
    
    private func stopTimer() -> Void {
        timer.invalidate()
    }
    
    private func startTimer() -> Void {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fetchConnections), userInfo: nil, repeats: timerRepeats)
        timer.fire()
    }
    
    func toggleTimer() -> Void {
        timerRepeats.toggle()
        timerRepeats ? startTimer() : stopTimer()
    }
}
