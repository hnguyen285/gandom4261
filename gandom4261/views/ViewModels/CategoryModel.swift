//
//  CategoryModel.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/10/21.
//

import Foundation

class CategoryModel: ObservableObject {
   @Published var category: [String] = ["Restaurant", "Coffee Shop", "Picnic", "Tourist"]
   @Published var randomCategory: String
   init() {
      randomCategory =  "boba"
   }
}
