//
//  HardwareConnectionViewModel.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation
import Combine
import Observation


@MainActor
@Observable
class HardwareConnectionViewModel {
    
    // TODO: Create Localized string file for translations
    enum Constants {
        
        // Connection messages
        static var lostSignalStatusMaxAttemptsReachedMessage: String = "Can't establish connection to device. insert helpful hint for better connection"
        static var lostSignalStatusRetriesAvailableMessage: String = "Attempting to re-establish connection"
        static var hardwareFailureStatusMessage: String = "Device Failure: schedule appointment for maintinence immediately"
        static var lowPowerLevelStatusMessage: String = "Low battery Levels: Please charge or find power source"
        static var expiredPodStatusMessage: String = "Pod Expired"
        
    }
    private(set) var connectButtonDisabled = false
    private(set) var connectionState = ""

    private let hardwareProvider: HardwareProviderProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    let maxRetryConnectionAttempts = 3
    var retryAttempts = 0
    
    init(hardwareProvider: HardwareProviderProtocol) {
        self.hardwareProvider = hardwareProvider
        
        hardwareProvider.hardwareConnectionStatePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] connectionState in
                self?.connectionState = "\(connectionState.connectionStateString)"
            })
            .store(in: &subscriptions)
    }
    
    func connect() async {
        connectButtonDisabled = true
        do {
            let result = try await hardwareProvider.connectToHardware()
            connectionState = "\(result)"
            connectButtonDisabled = result == .unknown
            retryAttempts = 0
        } catch(HardwareConnectionError.expiredPod) {
            connectionState = Constants.expiredPodStatusMessage
            connectButtonDisabled = true
        } catch(HardwareConnectionError.lostSignal) {
            if retryAttempts <= maxRetryConnectionAttempts {
                retryAttempts+=1
                connectButtonDisabled = true
                connectionState = Constants.lostSignalStatusRetriesAvailableMessage
                await connect()
            } else {
                connectionState = Constants.lostSignalStatusMaxAttemptsReachedMessage
                connectButtonDisabled = false
            }
        } catch(HardwareConnectionError.lowPowerLevel) {
            connectionState = Constants.lowPowerLevelStatusMessage
            connectButtonDisabled = false
        } catch {
            connectionState = Constants.hardwareFailureStatusMessage
            connectButtonDisabled = true
        }
    }
}
