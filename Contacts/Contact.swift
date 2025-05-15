//
//  Contact.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/10/25.
//

import Foundation

struct Contact: Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var phone: String
}
