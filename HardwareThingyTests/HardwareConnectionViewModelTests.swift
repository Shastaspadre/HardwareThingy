//
//  HardwareConnectionViewModelTests.swift
//  HardwareThingy
//
//  Created by Robert Dates on 7/16/25.
//


import Testing
@testable import HardwareThingy

struct HardwareConnectionViewModelTests {
    
    @Test func testHardwareConnectionViewModelInit() async  {
        // Given
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: .unknown)
        
        // When
        
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        
        // Then
        await MainActor.run {
            #expect("" == sut.connectionState)
            #expect(false == sut.connectButtonDisabled)
        }
    }
    
    @Test func testConnectionButtonDisabledOnInitialConnectButtonPress() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState)
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        // When
        await sut.connect()
        
        // Then
        await MainActor.run {
            #expect(sut.connectButtonDisabled == true)
        }
    }
    
    @Test func testViewStateOnConnectionSuccess() async {
        // Given
        let connectionState: HardwareConnectionState = .connected
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState)
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        
        // When
        await sut.connect()
        
        // Then
        await MainActor.run {
            #expect(sut.connectButtonDisabled == false)
            #expect(HardwareConnectionState.connected.connectionStateString == sut.connectionState)
            #expect(sut.retryAttempts == 0)
        }
    }

    @Test func testViewStateOnConnectionFailureExpiredPod() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .expiredPod)
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        
        // When
        await sut.connect()
        
        // Then
        await MainActor.run {
            #expect(sut.connectButtonDisabled == true)
            #expect(HardwareConnectionViewModel.Constants.expiredPodStatusMessage == sut.connectionState)
            #expect(sut.retryAttempts == 0)
        }
    }

    @Test func testViewStateOnConnectionFailureLowPowerLevel() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .lowPowerLevel)
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        
        // When
        await sut.connect()
        
        // Then
        await MainActor.run {
            #expect(sut.connectButtonDisabled == false)
            #expect(HardwareConnectionViewModel.Constants.lowPowerLevelStatusMessage == sut.connectionState)
            #expect(sut.retryAttempts == 0)
        }
    }

    @Test func testViewStateOnConnectionFailureHardwareFailure() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .hardwareFailure)
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        
        // When
        await sut.connect()
        
        // Then
        await MainActor.run {
            #expect(sut.connectButtonDisabled == true)
            #expect(HardwareConnectionViewModel.Constants.hardwareFailureStatusMessage == sut.connectionState)
            #expect(sut.retryAttempts == 0)
        }
    }

    @Test func testViewStateOnConnectionFailureLostSignalMaxAttempts() async {
        // Given
        let connectionState: HardwareConnectionState = .unknown
        let mockHardWareProvider = MockHardwareProvider(stubConnectionState: connectionState, error: .lostSignal)
        let sut = await MainActor.run {
            HardwareConnectionViewModel(hardwareProvider: mockHardWareProvider)
        }
        
        // When
        await sut.connect()
        
        // Then
        await MainActor.run {
            #expect(sut.connectButtonDisabled == false)
            #expect(HardwareConnectionViewModel.Constants.lostSignalStatusMaxAttemptsReachedMessage == sut.connectionState)
            #expect(sut.retryAttempts == 4)
        }
    }

    @Test func testViewStateOnConnectionFailureLostSignalUnderMaxAttempts() async {
        // TODO: Could add logging to be used to assert here. Also logging would be beneficial to the application for general usage purposes.
    }

}
