//
//  HardwareConnectionView.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import SwiftUI

struct HardwareConnectionView: View {
    private var viewModel = HardwareConnectionViewModel(hardwareProvider: HardwareProvider())
    
    var body: some View {
        VStack {
            Button("Connect") {
                Task {
                    await viewModel.connect()
                }
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

#Preview {
    HardwareConnectionView()
}
