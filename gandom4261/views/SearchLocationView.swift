//
//  SearchLocationView.swift
//  gandom4261
//
//  Created by Tuan Ho on 11/6/21.
//

import Foundation
import MapKit
import SwiftUI

struct SearchLocationView: View {

  
    @State private var search: String = ""
    @State private var result: [PlaceInfo] = []
    @State private var placeName: String = ""
    @State private var placeAddress: String = ""
    
    private func getNearByLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                //+print(mapItems)
                self.result = mapItems.map {
                    PlaceInfo(placemark: $0.placemark)
                }
                print(result)
                let place = self.result.randomElement()
                placeName = place!.name
                placeAddress = place!.address
                print(place?.name as Any)
                
            }
            
        }
        //print(self.result.randomElement())
    }

    var body: some View {
        ZStack(alignment: .top) {
            
            //MapView(landmarks: landmarks)
            
            TextField("Search", text: $search, onEditingChanged:  { _ in })
            {
                // commit
                self.getNearByLandmarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: 44)
            
            VStack {
                Text(placeName)
                Text(placeAddress)
                
            }
        }
    }
}

