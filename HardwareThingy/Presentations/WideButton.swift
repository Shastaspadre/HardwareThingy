//
//  WideButton.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/4/25.
//

import Foundation
import SwiftUI

struct WideButton: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled

    var pressedColor = Color.blue.opacity(0.5)
    var normalColor = Color.blue
    var disabledColor = Color.gray
        
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 33)
            .padding(10)
            .background(content: {
                if !isEnabled {
                    disabledColor
                } else {
                    configuration.isPressed ? pressedColor : normalColor
                }
            })
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
