//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

struct HardwareProvider: HardwareProviderProtocol {
    func connectToHardware() -> any AsyncSequence<HardwareConnectionState, Never> {
        HardwareConnector()
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
