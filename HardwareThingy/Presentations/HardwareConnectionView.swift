//
//  HardwareConnectionView.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import SwiftUI

struct HardwareConnectionView: View {
    @ObservedObject private var viewModel = HardwareConnectionViewModel()
    
    var body: some View {
        VStack {
            Button("Connect") {
                viewModel.connect()
            }
            .disabled(viewModel.connectButtonDisabled)
            .buttonStyle(WideButton())
            
            HStack {
                Text("Connection state:")
                Spacer()
                Text(viewModel.connectionState)
            }
        }
        .padding()
    }
}
