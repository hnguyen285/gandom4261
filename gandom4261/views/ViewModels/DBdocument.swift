//
//  DBdocument.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/11/21.
//

import Foundation
struct DBdocument: Hashable {
   var id = UUID()
   var category: String = ""
   var name: String = ""
   var addr: String = ""
   var long: Double = 0.0
   var lat: Double = 0.0
}
