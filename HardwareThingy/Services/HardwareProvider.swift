//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

struct HardwareProvider: HardwareProviderProtocol {
    private let hardwareConnector = HardwareConnector()
    
    func connectToHardware() -> any AsyncSequence<HardwareConnectionState, Never> {
        hardwareConnector
    }
    
    private struct HardwareConnector: AsyncSequence, AsyncIteratorProtocol {
        private var connectionState = HardwareConnectionState.unknown
        
        mutating func next() async -> HardwareConnectionState? {
            switch connectionState {
                case .unknown:
                    connectionState = .connecting
                    return connectionState
                case .connecting:
                    try? await Task.sleep(for: .seconds(1))
                    connectionState = .connected
                    return connectionState
                default:
                    return nil
            }
        }
        
        func makeAsyncIterator() -> HardwareConnector {
            self
        }
    }
}
