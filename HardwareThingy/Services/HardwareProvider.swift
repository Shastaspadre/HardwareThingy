//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation
import Combine

class HardwareProvider: HardwareProviderProtocol {
    func connectToHardware() async throws -> HardwareConnectionState {
        
        hardwareConnectionStateSubject.send(.connecting)
        
        try await Task.sleep(for: .seconds(2))
        
        let randomInt = Int.random(in: 0...5) // Gives provider ability to simulate connection errors
        if randomInt <= 3 {
            let cases = HardwareConnectionError.allCases
            throw cases[randomInt]
        }
        
        hardwareConnectionStateSubject.send(.connecting)
        
        return .connected
    }
    
    private var hardwareConnectionStateSubject = CurrentValueSubject<HardwareConnectionState, Error>(.unknown)
    lazy var hardwareConnectionStatePublisher = hardwareConnectionStateSubject.eraseToAnyPublisher()
    
    func connectToHardware() async -> Result<HardwareConnectionState, any Error> {
        hardwareConnectionStateSubject.send(.connecting)
        
        try? await Task.sleep(for: .seconds(2))
        
        hardwareConnectionStateSubject.send(.connecting)
        
        return .success(.connected)
    }
}
