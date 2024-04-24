import SwiftUI
import Foundation

struct ContentView: View {
    @State private var subject: String = ""
    @State private var message: String = ""
    @State private var response: String = ""
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State private var date: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Welcome to Aims \n")
                .font(.custom("Copperplate", size: 30))
                .bold()
            
            Text("Your handy AI messaging service\n")
                .font(.custom("Cochin", size: 15))
                .italic()
            
            HStack {
                Text("Enter message subject: ")
                    .font(.custom("Calibri", size: 15))
                    .bold()
                
                TextField("Subject",text:$subject)
                    .foregroundColor(Color.orange)
                    .italic()
                    .monospaced()
            }
            .padding()
            
            ScrollView {
                TextEditor(text: $message)
                    .frame(minHeight: 100)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.orange)
                    .bold(true)
                    .monospaced()
                
                TextEditor(text: $response)
                    .frame(minHeight: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.orange)
                    .bold(true)
                    .monospaced()
            }
            
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
                Text("Send Message")
                    .padding(.horizontal, 20)

                            .padding(.vertical, 8)

                            .foregroundColor(.white)
                            .background(.pink)
                            .cornerRadius(8)
                    .font(.custom("Calibri", size: 20))
                    .padding(20)
                    .controlSize(.large)
            })
            
            
        }
        .background(Color.blue)
        .font(.custom("Monospaced", size: 15))
        
    }
         
         // Define sendRequest function here
         func sendRequest(message: String, completion: @escaping (String?, Error?) -> Void) {
             NetworkManager.sendRequest(message: message, completion: completion)
         }
    func searchFlights() {
          // Call your Flask server endpoint here
          let urlString = "https://famous-crossing-420503.wl.r.appspot.com/search?origin=\(origin)&destination=\(destination)&date=\(date)"
          guard let url = URL(string: urlString) else { return }
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  let responseString = String(decoding: data, as: UTF8.self)
                  print("Response: \(responseString)")
              }
          }.resume()
      }
    func search(){
        let headers = [
            "X-RapidAPI-Key": "f0d643a60bmsh71276641854f9fcp1e2215jsnacc7fba10b01",
            "X-RapidAPI-Host": "skyscanner80.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://skyscanner80.p.rapidapi.com/api/v1/get-config")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
        })

        dataTask.resume()
    }
     }

     #if DEBUG
     struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
             ContentView()
         }
     }
     #endif
