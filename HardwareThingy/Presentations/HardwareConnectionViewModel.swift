//
//  HardwareConnectionViewModel.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation
import Combine

@MainActor
@Observable
class HardwareConnectionViewModel {
    private(set) var connectButtonDisabled = false
    private(set) var connectionState = "🤷🏻"
    
    private let hardwareProvider = HardwareProvider()
        
    func connect() {
        connectButtonDisabled = true

        Task {
            defer {
                connectButtonDisabled = false
            }
            
            for try await connectionState in hardwareProvider.connectToHardware() {
                self.connectionState = "\(connectionState)"
            }
        }
    }
}
