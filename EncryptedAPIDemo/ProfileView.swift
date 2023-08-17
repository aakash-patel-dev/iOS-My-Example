//
//  ProfileView.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 19/05/22.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.editMode) var mode
    
    var items = [
        "Edit Profile", "Change Password", "Terms & Conditions", "Privacy Policy", "Logout"
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image("2")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .scaledToFill()
                        .clipShape(Circle())
                    Text("James Smith")
                        .font(.title2)
                    Text("james@gmail.com")
                }
                VStack {
                    ForEach(items, id: \.self) { data in
                        Text(data)
                            .font(.title3)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 45, alignment: .leading)
                            .padding(.horizontal)
                            .background(.orange.opacity(0.3))
                            .cornerRadius(10)
                    }
                }.padding()
            }.padding(.top, 30)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
