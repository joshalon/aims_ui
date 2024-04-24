//
//  LoginView.swift
//  AIMS
//
//  Created by New Account on 4/23/24.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @State private var subject: String = ""
    @State private var message: String = ""
    @State private var response: String = ""
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State private var date: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Welcome to Aims \n")
                .font(.custom("Copperplate", size: 30))
                .bold()
            
            Text("Your handy AI messaging service\n")
                .font(.custom("Cochin", size: 15))
                .italic()
            
          
            .padding()
       
            Button(action: {
                NetworkManager.sendRequest(message: message) { response, error in
                    if let error = error {
                        // Handle error
                        print("Error: \(error)")
                    } else if let response = response {
                        // Add this line
                        // Update the response
                        self.response = response
                    }
                }
            }, label: {
                Text("Login with G-Mail")
                    .padding(.horizontal, 20)

                            .padding(.vertical, 8)

                            .foregroundColor(.white)
                            .background(.pink)
                            .cornerRadius(8)
                    .font(.custom("Calibri", size: 20))
                
                    .controlSize(.large)
            })
            
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .background(Color.blue)
        .font(.custom("Monospaced", size: 15))
        
    }
         
         // Define sendRequest function here
         func sendRequest(message: String, completion: @escaping (String?, Error?) -> Void) {
             NetworkManager.sendRequest(message: message, completion: completion)
         }

        }

     #if DEBUG
     struct LoginView_Previews: PreviewProvider {
         static var previews: some View {
             LoginView()
         }
     }
     #endif

