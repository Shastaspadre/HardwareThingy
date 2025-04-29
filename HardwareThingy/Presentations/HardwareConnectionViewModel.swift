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
    
    init() {
        listenToConnectionStateChanges()
    }
    
    private func listenToConnectionStateChanges() {
        Task {
            for try await connectionState in hardwareProvider.stream {
                self.connectionState = "\(connectionState)"
            }
        }
    }
    
    func connect() {
        connectButtonDisabled = true
        
        Task {
            defer {
                connectButtonDisabled = false
            }
            
            await hardwareProvider.connectToHardware()
        }
    }
        
//    func connect() {
//        connectButtonDisabled = true
//
//        Task {
//            defer {
//                connectButtonDisabled = false
//            }
//            
//            for try await connectionState in hardwareProvider.connectToHardware() {
//                self.connectionState = "\(connectionState)"
//            }
//        }
//    }
}
