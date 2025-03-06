//
//  HardwareProvider.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation

actor HardwareProvider: HardwareProviderProtocol {
    func connectToHardware(onConnectionStateChanged: (HardwareConnectionState) -> Void) {
        onConnectionStateChanged(HardwareConnectionState.connecting)
        
        Thread.sleep(forTimeInterval: 2)
        
        onConnectionStateChanged(HardwareConnectionState.connected)
    }
}
