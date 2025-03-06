//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation
import Combine

class HardwareProvider: HardwareProviderProtocol {
    private var hardwareConnectionStateSubject = CurrentValueSubject<HardwareConnectionState, Error>(.unknown)
    lazy var hardwareConnectionStatePublisher = hardwareConnectionStateSubject.eraseToAnyPublisher()
    
    func connectToHardware() async -> Result<HardwareConnectionState, any Error> {
        hardwareConnectionStateSubject.send(.connecting)
        
        try? await Task.sleep(for: .seconds(2))
        
        hardwareConnectionStateSubject.send(.connecting)
        
        return .success(.connected)
    }
}
