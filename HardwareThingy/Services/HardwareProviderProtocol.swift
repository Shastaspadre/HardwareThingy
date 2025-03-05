//
//  HardwareProviderProtocol.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

enum HardwareConnectionState {
    case unknown
    case connecting
    case connected
    case disconnected
}

protocol HardwareProviderProtocol {
    var hardwareConnectionState: HardwareConnectionState { get }
    var hardwareConnectionStatePublisher: Published<HardwareConnectionState>.Publisher { get }
    
    func connectToHardware() async -> Result<HardwareConnectionState, Error>
}
