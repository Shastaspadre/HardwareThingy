//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

class HardwareProvider: HardwareProviderProtocol {
    @Published private(set) var hardwareConnectionState = HardwareConnectionState.unknown
    var hardwareConnectionStatePublisher: Published<HardwareConnectionState>.Publisher { $hardwareConnectionState }
    
    func connectToHardware() async -> Result<HardwareConnectionState, any Error> {
        hardwareConnectionState = .connecting
        
        try? await Task.sleep(for: .seconds(2))
        
        hardwareConnectionState = .connected
        
        return .success(.connected)
    }
}
