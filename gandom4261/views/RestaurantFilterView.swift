//
//  ConstraintView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/7/21.
//

import SwiftUI

struct RestaurantFilterView: View {
   
   
   
   var distances = ["N/A", "05 miles", "10 miles", "15 miles", "30 miles"]
   @State private var selectedDistance = "N/A"
   
   var priceLevel = ["N/A", "05 miles", "10 miles", "15 miles", "30 miles"]
   @State private var selectedPrice = "N/A"
   
   var types = ["N/A", "Noodle Soup", "BBQ", "Sushi Bar", "Fastfood"]
   @State private var selectedType = "N/A"
   
   var body: some View {
      NavigationView {
         VStack {
            HStack(){
               Spacer()
               Text("In Distance ")
               Spacer()
               Picker("In Distance", selection: $selectedDistance) {
                  ForEach(distances, id: \.self) {
                     Text($0)
                  }
               }
               Spacer()
            }
            
            HStack(){
               Spacer()
               Text("Price Level ")
               Spacer()
               Picker("Price Level", selection: $selectedPrice) {
                  ForEach(priceLevel, id: \.self) {
                     Text($0)
                  }
               }
               Spacer()
            }
            
            HStack(){
               Spacer()
               Text("Type")
               Spacer()
               Picker("Price Level", selection: $selectedPrice) {
                  ForEach(priceLevel, id: \.self) {
                     Text($0)
                  }
               }
               Spacer()
            }
         }
         
      }
      .navigationTitle("Filter")
         .navigationBarTitleDisplayMode(.inline)
      
   }
}

struct ConstraintView_Previews: PreviewProvider {
   static var previews: some View {
      RestaurantFilterView()
   }
}
