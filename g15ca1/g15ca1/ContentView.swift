//
//  ContentView.swift
//  g15ca1
//
//  Created by Student on 02/11/22.
//
/*import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                Text("account creation page")
            }
            .navigationTitle("Create Account")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
import SwiftUIX

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoginMode = false
    // 2
    @Published var isPickingImage = false
    @Published var imageData: Data?
}

struct ContentView: View {
    
    @ObservedObject var vm = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker(selection: $vm.isLoginMode, label: Text("Picker"), content: {
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }).pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical)
                    
                    if !vm.isLoginMode {
                        // 3
                        Button(action: {vm.isPickingImage.toggle()}, label: {
                            ZStack {
                                if let imageData = vm.imageData {
                                    Image(uiImage: UIImage(data: imageData)!)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "person.fill")
                                }
                            }.frame(width: 160, height: 160)
                            .clipped()
                            .cornerRadius(80)
                            .font(.system(size: 80))
                            .overlay(RoundedRectangle(cornerRadius: 80).stroke(lineWidth: 3))
                            .shadow(radius: 5 )
                        })
                        .foregroundColor(.black)
                        .padding()
                        // 4
                        .fullScreenCover(isPresented: $vm.isPickingImage, content: {
                            ImagePicker(data: $vm.imageData, encoding: .jpeg(compressionQuality: 0.1))
                        })
                    }
                    
                    Group {
                        TextField("Email", text: $vm.email)
                            .keyboardType(.emailAddress)
                        SecureField("Password", text: $vm.password, onCommit: handleCreateAccount)
                    }.padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    Button(action: handleCreateAccount, label: {
                        HStack {
                            Spacer()
                            Text(vm.isLoginMode ? "Log in" : "Create Account")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                        }
                    }).padding()
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding(.top)
                }
                .padding(.horizontal)
            }.background(Color(white: 0.92).ignoresSafeArea())
            .navigationTitle(vm.isLoginMode ? "Log in" : "Create Account")
        }
    }
    
    private func handleCreateAccount() {
        
    }
}
