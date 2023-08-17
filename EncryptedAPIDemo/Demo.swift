//
//  Demo.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 11/05/22.
//

import SwiftUI

struct Demo: View {
    
    var list = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N"]
    
    var menuArr = [
        Menu(name: "Pizza", quantity: "10Pcs", price: "10$"),
        Menu(name: "Burger", quantity: "5Pcs", price: "5$"),
        Menu(name: "Pulav", quantity: "2Pcs", price: "15$"),
        Menu(name: "Chinease", quantity: "1Pcs", price: "8$"),
        Menu(name: "Italian Pizza", quantity: "8Pcs", price: "12$"),
        Menu(name: "Sandwich", quantity: "2Pcs", price: "5$")
    ]
    
    @State var fname = ""
    @State var lname = ""
    @State var email = ""
    @State var password = ""
    @State var address = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Login")
                    .font(.system(size: 35, weight: .bold, design: .default))
                
                Spacer()
            }.padding(.horizontal, 20)
            
            VStack(spacing: 15) {
                CustomTextField(value: $email, placeholder: "Enter Email")
                CustomTextField(value: $password, placeholder: "Enter Password")
                
                HStack {
                    Spacer()
                    Button {print("Button tapped")} label: {
                        Text("Forgot Password?")
                            .foregroundColor(.black)
                    }
                }
                
                Button {print("Button tapped")} label: {
                    Text("Login")
                }.buttonStyle(.plain)
                    .frame(width: 150, height: 45)
                    .background(.green.opacity(0.4))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black.opacity(0.6)))
                    .padding(.top, 5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: -5, y: -5)

            }.padding([.horizontal], 20)
                .padding([.vertical], 30)
                .background(.green.opacity(0.6))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .shadow(color: .gray, radius: 5, x: -10, y: -10)
        }
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Demo()
                .previewInterfaceOrientation(.portrait)
            Demo()
                .previewInterfaceOrientation(.landscapeLeft)
            Demo()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}


class Menu: Identifiable {
    var uuid = UUID()
    var name = ""
    var quantity = ""
    var price = ""
    
    init(name: String, quantity: String, price: String) {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}

struct CustomTextField: View {
    
    @Binding var value: String
    var placeholder: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $value)
            .frame(height: 50)
            .textFieldStyle(.plain)
            .padding(.horizontal)
            .background(.white.opacity(0.6))
            .cornerRadius(22)
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(.black.opacity(0.6)))
        }
    }
}
