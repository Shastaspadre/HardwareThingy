//
//  ContactDetailView.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/10/25.
//

import SwiftUI

struct ContactDetailView: View {
    var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(contact.name)")
                .padding(.bottom, 10)
            Text("Email: \(contact.email)")
                .padding(.bottom, 10)
            Text("Phone: \(contact.phone)")
                .padding(.bottom, 10)
            
            Spacer()
        }
    }
}

#Preview {
    ContactDetailView(contact: Contact(id: UUID(), name: "J. Doe", email: "jdoe@insulet.com", phone: "555-1212"))
}
