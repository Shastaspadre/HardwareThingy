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
}

protocol HardwareProviderProtocol {
    var hardwareConnectionStatePublisher: AnyPublisher<HardwareConnectionState, Error> { get }
    
    func connectToHardware() async -> Result<HardwareConnectionState, Error>
}
