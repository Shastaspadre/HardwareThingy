//
//  ContactListView.swift
//  HardwareThingy
//
//  Created by John Dumais on 3/10/25.
//

import SwiftUI

struct ContactListView: View {
    var contacts: [Contact]
    
    var body: some View {
        NavigationView {
            List(contacts) { contact in
                NavigationLink(destination: ContactDetailView(contact: contact)) {
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactListView(contacts: [
        Contact(name: "John Doe", email: "john@example.com", phone: "123-456-7890"),
        Contact(name: "Jane Smith", email: "jane@example.com", phone: "987-654-3210"),
        Contact(name: "Sam Brown", email: "sam@example.com", phone: "555-123-4567")
    ])
}
