//
//  CategoryView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/7/21.
//

import SwiftUI

struct CategoryView: View {
   
   @EnvironmentObject var viewModel: SigninViewModel
   
   var category: [String] = ["Restaurant", "Coffee Shop", "Picnic", "Tourist"]
   
   var body: some View {
      
      ScrollView(showsIndicators: false) {
         Spacer()
         
         VStack() {
            ForEach(category, id: \.self) {
               CategorySubView(content: $0)
            }
            
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
         SuggestionView(content: getRandomCategory())
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
   
   func getRandomCategory() -> String {
      return category.randomElement() ?? "boba shop"
   }
}


struct CategoryView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryView()
   }
}
