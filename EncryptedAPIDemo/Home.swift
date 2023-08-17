//
//  Home.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 18/05/22.
//

import SwiftUI


struct Home: View {
    
    @State var item = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh"]
    
    @State var isProfileView = false
    
    var body: some View {
        NavigationView {
            
//            NavigationLink($isProfileView, destination: ProfileView()) {
//                EmptyView()
//            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    TopView(item: item)
                    RowView(item: item, heading: "Lakes")
                    
                    RowView(item: item, heading: "Mountains")
                }
                .navigationTitle("Featured")
                .toolbar {
                    Button {
                        print("Profile icon tapped")
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct ImageOverlay: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.system(.title2))
                .foregroundColor(.white.opacity(0.6))
            Text("Joshua The National Park")
                .foregroundColor(.white.opacity(0.6))
        }.padding(8)
        .background(.black.opacity(0.5))
        .cornerRadius(5)
        .padding(12)
    }
}

struct RowView: View {
    
    var item: [String]!
    var heading: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .font(.system(.title2))
                .padding(.horizontal)

            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(item, id: \.self) { data in
                        VStack(alignment: .leading) {
                            Image("3")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .scaledToFill()
                                .cornerRadius(10)
                            Text(data)
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct TopView: View {
    var item: [String]!
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                ForEach(item, id: \.self) { data in
                    Image("2")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 220)
                        .scaledToFill()
                        .overlay(ImageOverlay(), alignment: .bottomLeading)
                }
            }
        }
    }
}
