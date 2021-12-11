//
//  ConstraintView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/7/21.
//

import SwiftUI


struct RestaurantFilterView: View {
   
   var category: String
   
   var distances = ["N/A", "05 miles", "10 miles", "15 miles", "30 miles"]
   @State private var selectedDistance = "N/A"
   
   var priceLevel = ["N/A", "$", "$$", "$$$", "$$$$"]
   @State private var selectedPrice = "N/A"
   
   var types = ["N/A", "Noodle Soup", "BBQ", "Sushi Bar", "Fastfood"]
   @State private var selectedType = "N/A"
   
   var body: some View {

         VStack() {
            HStack(){
               
               Text("In Distance: ")
               Spacer()
               Picker("In Distance", selection: $selectedDistance) {
                  ForEach(distances, id: \.self) {
                     Text($0)
                  }
               }
               
            }.padding(40)
            
            HStack(){
               
               Text("Price Level: ")
               Spacer()
               Picker("Price Level", selection: $selectedPrice) {
                  ForEach(priceLevel, id: \.self) {
                     Text($0)
                  }
               }
               
            }.padding(40)
            
            HStack(){
               
               Text("Type:")
               Spacer()
               Picker("Type", selection: $selectedType) {
                  ForEach(types, id: \.self) {
                     Text($0)
                  }
               }
               
            }.padding(40)
            
            NavigationLink {
               SuggestionView(content: category, isGetaway: false)
            } label: {
               ZStack {
                  RoundedRectangle(cornerRadius: 15)
                     .stroke(Color.green)
                     .frame(width: 160, height: 50, alignment: .center)
                  
                  Text("Confirm")
                     .font(.title2)
                     .foregroundColor(Color.green)
                     .frame(width: 160, height: 50)
                     .cornerRadius(15)
               }
            }

         }
         
      .navigationTitle("Filter")
      .navigationBarTitleDisplayMode(.inline)
      
   }
}

struct ConstraintView_Previews: PreviewProvider {
   static var previews: some View {
      RestaurantFilterView(category: "Restaurant")
   }
}
