//
//  ContentView.swift
//  KanamangalaPreeth-HW10
//
// Project: KanamangalaPreeth-HW10
// EID: PK9297
// Course: CS371L
//

import SwiftUI

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var status: String = "Not currently logged in"
    
    var body: some View {
        VStack(alignment: .center) {
            Text("User Login")
                .padding()
                .padding(.bottom, 50)
            // horizontal stack for username label and text field
            HStack() {
                Text("userID:")
                    .padding()
                TextField("", text: $username)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            // horizontal stack for password label and text field
            HStack() {
                Text("Password:")
                    .padding()
                TextField("", text: $password)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            // if the log in button is pressed, check if the user and password text fields are empty
            // change the status label text based on if either one is empty
            Button(action: {
                if "\(username)" == "" || "\(password)" == "" {
                    status = "Invalid login"
                } else {
                    status = "\(username) logged in"
                }
            }) {
                Text("Login")
                    .padding()
                    .padding(.top, 100)
            }
            // display the state status variable
            Text(status)
                .padding()
                .padding(.bottom, 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
