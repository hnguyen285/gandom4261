//
//  SearchLocationView.swift
//  gandom4261
//
//  Created by Tuan Ho on 11/6/21.
//

import Foundation
import MapKit
import SwiftUI


struct CategorySubView: View {
   
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
                  .opacity(0.7)
                  .cornerRadius(10)
               Text(content)
                  .frame(width: 280, height: 100, alignment: .leading)
                  .foregroundColor(.white)
                  .font(.largeTitle)
            }.frame(width: 300, height: 100)
            
         }
      }.padding(.vertical, 10)
   }
}
