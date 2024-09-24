//
//  NetworkMonitor.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation
import Network
import Combine

class NWMonitor {
    // MARK: - Properties
    static let shared = NWMonitor()

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    @Published private(set) var isConnected: Bool = true
    private(set) var connectionType: NWInterface.InterfaceType?

    // MARK: - Life Cycle
    init() {
        self.monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.isConnected = path.status == .satisfied
            self.connectionType = self.getConnectionType(path)
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }

    private func getConnectionType(_ path: NWPath) -> NWInterface.InterfaceType? {
        if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .wiredEthernet
        } else if path.usesInterfaceType(.loopback) {
            return .loopback
        } else if path.usesInterfaceType(.other) {
            return .other
        } else {
            return nil
        }
    }
}
