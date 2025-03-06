//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

actor HardwareProvider: HardwareProviderProtocol {
    func connectToHardware(onConnectionStateChanged: OnConnectionStateChanged) {
        onConnectionStateChanged(HardwareConnectionState.connecting)
        
        Thread.sleep(forTimeInterval: 2)
        
        onConnectionStateChanged(HardwareConnectionState.connected)
    }
}
