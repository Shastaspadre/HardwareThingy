//
//  HardwareConnectionViewModelTests.swift
//  HardwareThingyTests
//
//  Created by Robert Dates on 7/15/25.
//
import XCTest
@testable import HardwareThingy

@MainActor
class XCTestCaseHardwareConnectionViewModelTests: XCTestCase {
    
    func testInitialization() {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState)
        
        // When
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // Then
        XCTAssertEqual("", sut.connectionState)
        XCTAssertFalse(sut.connectButtonDisabled)
    }
    
    func testConnectionButtonDisabledOnInitialConnectButtonPress() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState)
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // When
        await sut.connect()
        
        // Then
        XCTAssertTrue(sut.connectButtonDisabled)
    }
    
    func testViewStateOnConnectionSuccess() async {
        // Given
        let connectionState: HardwareConnectionState = .connected
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState)
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // When
        await sut.connect()
        
        // Then
        XCTAssertFalse(sut.connectButtonDisabled)
        XCTAssertEqual(HardwareConnectionState.connected.connectionStateString, sut.connectionState)
        XCTAssertEqual(sut.retryAttempts, 0)
    }

    func testViewStateOnConnectionFailureExpiredPod() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .expiredPod)
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // When
        await sut.connect()
        
        // Then
        XCTAssertTrue(sut.connectButtonDisabled)
        XCTAssertEqual(HardwareConnectionViewModel.Constants.expiredPodStatusMessage, sut.connectionState)
        XCTAssertEqual(sut.retryAttempts, 0)
    }

    func testViewStateOnConnectionFailureLowPowerLevel() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .lowPowerLevel)
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // When
        await sut.connect()
        
        // Then
        XCTAssertFalse(sut.connectButtonDisabled)
        XCTAssertEqual(HardwareConnectionViewModel.Constants.lowPowerLevelStatusMessage, sut.connectionState)
        XCTAssertEqual(sut.retryAttempts, 0)
    }

    func testViewStateOnConnectionFailureHardwareFailure() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .hardwareFailure)
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // When
        await sut.connect()
        
        // Then
        XCTAssertTrue(sut.connectButtonDisabled)
        XCTAssertEqual(HardwareConnectionViewModel.Constants.hardwareFailureStatusMessage, sut.connectionState)
        XCTAssertEqual(sut.retryAttempts, 0)
    }

    func testViewStateOnConnectionFailureLostSignalMaxAttempts() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .lostSignal)
        let sut = HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        
        // When
        await sut.connect()
        
        // Then
        XCTAssertFalse(sut.connectButtonDisabled)
        XCTAssertEqual(HardwareConnectionViewModel.Constants.lostSignalStatusMaxAttemptsReachedMessage, sut.connectionState)
        XCTAssertEqual(sut.retryAttempts, 4)
    }
    
    func testViewStateOnConnectionFailureLostSignalUnderMaxAttempts() async {
        // TODO: Could add logging to be used to assert here. Also logging would be beneficial to the application for general usage purposes.
    }
}
