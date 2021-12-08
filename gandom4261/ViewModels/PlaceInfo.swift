//
//  PlaceInfo.swift
//  gandom4261
//
//  Created by Tuan Ho on 11/6/21.
//

import Foundation
import MapKit

struct PlaceInfo {
   
   let placemark: MKPlacemark
   var name: String {
      self.placemark.name ?? ""
   }
   var address: String {
      self.getAddress(placemarks: self.placemark)
   }
   
   func getAddress(placemarks: MKPlacemark) -> String {
      let addressFirstLine = [placemarks.subThoroughfare,
                              placemarks.thoroughfare].compactMap {$0}.joined(separator: " ")
      let outputString = [addressFirstLine,
                          placemark.locality,
                          placemark.subLocality,
                          placemark.postalCode].compactMap{$0}.joined(separator: ", ")
      print(outputString)
      return outputString
   }
}
