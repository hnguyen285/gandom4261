//
//  SuggestionView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/7/21.
//

import SwiftUI
import MapKit
struct SuggestionView: View {
   var content: String
   @State private var search: String = ""
   @State private var result: [PlaceInfo] = []
   @State private var placeName: String = ""
   @State private var placeAddress: String = ""
   
   @EnvironmentObject var viewModel: SigninViewModel
   
   private func getNearByLandmarks() {
      let request = MKLocalSearch.Request()
      request.naturalLanguageQuery = search
      
      let search = MKLocalSearch(request: request)
      search.start { (response, error) in
         if let response = response {
            let mapItems = response.mapItems
            //            +print(mapItems)
            self.result = mapItems.map {
               PlaceInfo(placemark: $0.placemark)
            }
            //            print(result)
            let place = self.result.randomElement()
            placeName = place!.name
            placeAddress = place!.address
            //            print(place?.name as Any)
            
         }
         
      }
      //print(self.result.randomElement())
   }
   var body: some View {
      VStack {
         VStack(alignment: .leading) {
            Text("Category: \(content)")
               .fontWeight(.bold)
            Text(placeName)
            Text(placeAddress).frame(width: 300, height: 150, alignment: .leading)
            
            Spacer()
         }.font(.title)
            .frame(width: 300, height: 400)
            .onAppear {
               search = content
               getNearByLandmarks()
            }
         Button {
            getNearByLandmarks()
         } label: {
            ZStack {
               RoundedRectangle(cornerRadius: 15)
                  .stroke(Color.green)
                  .frame(width: 160, height: 50, alignment: .center)
               
               Text("Shuffle")
                  .font(.title2)
                  .foregroundColor(Color.green)
                  .frame(width: 160, height: 50)
               
                  .cornerRadius(15)
            }
            
         }
         
      }
      
   }
}

