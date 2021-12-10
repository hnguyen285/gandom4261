//
//  SuggestionView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/7/21.
//

import SwiftUI
import MapKit
struct SuggestionView: View {
   
   var category: [String] = ["Restaurant", "Coffee Shop", "Picnic", "Tourist"]
   @State var content: String
   var isGetaway: Bool
   
   
   @State private var search: String = ""
   @State private var result: Dictionary<String, Any> = [:]
   @State private var placeName: String = ""
   @State private var placeAddress: String = ""
   @State private var price: String = ""
   @State private var rating: String = ""
   @State private var descript: [String] = []
   
   @EnvironmentObject var viewModel: SigninViewModel
   
   func tryThis() {
       let headers = [
         "Accept": "application/json",
         "Authorization": "Bearer fptQQH-6MKQSd9IuZy8hHZk88BBNgzqbHR-0reJlLnTN6iAQFRewG2br8UvJ6n3h_qmAwGmtXuQCdtrDaoqHoxv-XcFcSTA8B4ycedGr1lb_NJF_J1tN1CgdU_qyYXYx"
       ]
//       var place = "fastfood"
//       var ll = "41.8781%2C-87.6298"
//       var url_string = "https://api.foursquare.com/v3/places/nearby?ll=" + ll + "&query=" + place
       //print(url_string)
       var yelp_url = "https://api.yelp.com/v3/businesses/search?term=boba&location=Morrow"
       let request = NSMutableURLRequest(url: NSURL(string: yelp_url)! as URL,
                                               cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
       request.httpMethod = "GET"
       request.allHTTPHeaderFields = headers

       let session = URLSession.shared
       let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
         if (error != nil) {
           print(error)
         } else {
             if let responseJSON = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:Any]{
                 print("what")
                 print(responseJSON)
                 self.result = responseJSON
                 
                 let place = self.result.randomElement()
                 print("Here")
                 //print(place)
                 
//                  self.placeName = place!.name
//                  self.placeAddress = place!.address
//                  self.rating = place!.rating
//                  self.price = place!.price
//                  for category_place in place!.categories {
//                      self.descript.append(category_place!.title)
//                  }
                 //print(place?.name as Any)
                     
                 
             }
         }
       })
       dataTask.resume()
   }
   
//   private func getNearByLandmarks() {
//      let request = MKLocalSearch.Request()
//      request.naturalLanguageQuery = search
//
//      let search = MKLocalSearch(request: request)
//      search.start { (response, error) in
//         if let response = response {
//            let mapItems = response.mapItems
//            //            +print(mapItems)
//            self.result = mapItems.map {
//               PlaceInfo(placemark: $0.placemark)
//            }
//            //            print(result)
//            let place = self.result.randomElement()
//            placeName = place!.name
//            placeAddress = place!.address
//            //            print(place?.name as Any)
//
//         }
//
//      }
//      //print(self.result.randomElement())
//   }
   
   func chooseContent() {
      if isGetaway == true {
         self.content = category.randomElement() ?? "boba"
         search = content
      }
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
               chooseContent()
//               getNearByLandmarks()
               tryThis()
            }
         Button {
            chooseContent()
//            getNearByLandmarks()
            tryThis()
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

