//
//  yelpData.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/10/21.
//

import Foundation
import CoreLocation

struct yelpData: Decodable {
   let total: Int
   let businesses: [Business]
}

struct Business: Decodable {
   let name: String
   let phone: String
   //let rating: String
   var price: String?
   var rating: Double?
   let display_phone: String?
   let location: Location?
   var distance: Double?
   
}

struct Location: Decodable {
   let address1: String?
   let city: String?
   let state: String?
   let zip_code: String?
}
