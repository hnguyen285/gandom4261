//
//  SearchLocationView.swift
//  gandom4261
//
//  Created by Tuan Ho on 11/6/21.
//

import Foundation
import MapKit
import SwiftUI

struct SearchLocationView: View {

    @EnvironmentObject var viewModel: SigninViewModel
    
    
    var body: some View {
        
        ScrollView {
            VStack() {
                CategoryView(content: "Restaurant")
                CategoryView(content: "Picnic")
                CategoryView(content: "Tourist")
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.red)
                        .frame(width: 300, height: 100)
                    Text("Last minute get away!")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 100)
                }
                
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Pick a place:")
            .toolbar {
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Sign Out")
                    
                }
            }
        }
        
        
        
    }
}

struct CategoryView: View {
    
    var content: String
 
    var body: some View {
        NavigationLink {
            SuggestionView(content: content)
        } label: {
            VStack{
                ZStack {
                    Image(content)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 100)
                        .mask {
                            
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 100)
                            
                        }
                    LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .leading, endPoint: .trailing)
                        .opacity(0.4)
                        .cornerRadius(10)
                    Text(content)
                        .frame(width: 280, height: 100, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }.frame(width: 300, height: 100)
                
            }
        }
    }
}
