//
//  MockHardwareProvider.swift
//  HardwareThingyTests
//
//  Created by Robert Dates on 7/16/25.
//

import Combine
import Testing
import XCTest
@testable import HardwareThingy

struct MockHardwareProvider: HardwareProviderProtocol {
    
    private let subject: CurrentValueSubject<HardwareThingy.HardwareConnectionState, Error> = .init(.unknown)
    var hardwareConnectionStatePublisher: AnyPublisher<HardwareThingy.HardwareConnectionState, any Error> {
        subject.dropFirst().eraseToAnyPublisher()
    }
    
    var stubConnectionState: HardwareThingy.HardwareConnectionState
    var stubError: HardwareConnectionError?
    
    init(stubConnectionState: HardwareThingy.HardwareConnectionState, error: HardwareConnectionError? = nil) {
        self.stubConnectionState = stubConnectionState
        self.stubError = error
    }
    
    func connectToHardware() async throws -> HardwareThingy.HardwareConnectionState {
        subject.send(completion: .finished)
        if let stubError {
            throw stubError
        }
        return stubConnectionState
    }
}
