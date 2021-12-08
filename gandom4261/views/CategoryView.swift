//
//  CategoryView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/7/21.
//

import SwiftUI

struct CategoryView: View {
   
   @EnvironmentObject var viewModel: SigninViewModel
   
   
   var body: some View {
      
      ScrollView(showsIndicators: false) {
         Spacer()
         VStack() {
            CategorySubView(content: "Restaurant")
            CategorySubView(content: "Coffee Shop")
            CategorySubView(content: "Picnic")
            CategorySubView(content: "Tourist")
            
         }
         .navigationTitle("Pick a Category")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
            Button {
               viewModel.signOut()
            } label: {
               Text("Sign Out")
               
            }
         }
      }.frame(maxWidth: .infinity, maxHeight: 400)
      
      NavigationLink {
         SuggestionView(content: "ALL")
      } label: {
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

      Spacer()
   }
}


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
