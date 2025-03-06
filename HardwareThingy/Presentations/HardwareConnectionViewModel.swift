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
    private(set) var connectionState = ""
    
    private let hardwareProvider = HardwareProvider()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        hardwareProvider.hardwareConnectionStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] connectionState in
                self?.connectionState = "\(connectionState)"
            }
            .store(in: &subscriptions)
    }
    
    func connect() {
        connectButtonDisabled = true

        Task {
            defer {
                connectButtonDisabled = false
            }
            
            if case .success(let connectionState) = await hardwareProvider.connectToHardware() {
                self.connectionState = "\(connectionState)"
            }
        }
    }
}
