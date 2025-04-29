//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

class HardwareProvider: HardwareProviderProtocol {
    private var continuation: AsyncStream<HardwareConnectionState>.Continuation?
    
    var stream: AsyncStream<HardwareConnectionState> {
        AsyncStream { (continuation: AsyncStream<HardwareConnectionState>.Continuation) -> Void in
            self.continuation = continuation
        }
    }
    
    func connectToHardware() async {
        continuation?.yield(.connecting)
        try? await Task.sleep(for: .seconds(1))
        continuation?.yield(.connected)
    }
    
//    private let hardwareConnector = HardwareConnector()
//    
//    func connectToHardware() -> any AsyncSequence {
//        hardwareConnector
//    }
//    
//    private struct HardwareConnector: AsyncSequence, AsyncIteratorProtocol {
//        private var connectionState = HardwareConnectionState.unknown
//        
//        mutating func next() async -> HardwareConnectionState? {
//            switch connectionState {
//                case .unknown:
//                    connectionState = .connecting
//                    return connectionState
//                case .connecting:
//                    try? await Task.sleep(for: .seconds(1))
//                    connectionState = .connected
//                    return connectionState
//                default:
//                    return nil
//            }
//        }
//        
//        func makeAsyncIterator() -> HardwareConnector {
//            self
//        }
//    }
}
