//
//  HardwareProviderProtocol.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation
import Combine

enum HardwareConnectionState {
    case unknown
    case connecting
    case connected
    case disconnected
    
    // TODO: Create localized strings for translations
    var connectionStateString: String {
        switch self {
        case .unknown:
            "unknown"
        case .connecting:
            "connecting"
        case .connected:
            "connected"
        case .disconnected:
            "disconnected"
        }
    }
}

enum HardwareConnectionError: Error, CaseIterable {
    case lostSignal
    case hardwareFailure
    case lowPowerLevel
    case expiredPod
}

protocol HardwareProviderProtocol {
    var hardwareConnectionStatePublisher: AnyPublisher<HardwareConnectionState, Error> { get }
    func connectToHardware() async throws -> HardwareConnectionState
}
