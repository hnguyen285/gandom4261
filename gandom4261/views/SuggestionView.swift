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
   
   @StateObject var locationManager = LocationManager()
   
   @State private var search: String = ""
   @State private var result: Dictionary<String, Any> = [:]
   @State private var placeName: String = ""
   @State private var placeAddress: String = ""
   @State private var price: String = ""
   @State private var rating: Double = 0.0
   @State private var distance: Double = 0.0
   @State private var phone: String = ""
   @State private var descript: [String] = []
   
   @EnvironmentObject var viewModel: SigninViewModel
   

   
   func performRequest() {
      let headers = [
         "Accept": "application/json",
         "Authorization": "Bearer fptQQH-6MKQSd9IuZy8hHZk88BBNgzqbHR-0reJlLnTN6iAQFRewG2br8UvJ6n3h_qmAwGmtXuQCdtrDaoqHoxv-XcFcSTA8B4ycedGr1lb_NJF_J1tN1CgdU_qyYXYx"
      ]
      let yelp_url = "https://api.yelp.com/v3/businesses/search?term=boba&location=Morrow"
      let request = NSMutableURLRequest(url: NSURL(string: yelp_url)! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers

      let session = URLSession.shared
      let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
         if error != nil {
            print("\(error!) OCCURRED HERE")
            return
         }
         if let safeData = data {
            self.parseJSON(data: safeData)
         }
      }
      )
      dataTask.resume()
   }
   func parseJSON(data: Data) {
      let decoder = JSONDecoder()
      do {
         let decodedData = try decoder.decode(yelpData.self, from: data)
         let loc = decodedData.businesses.randomElement()
//         print(loc)
         guard let validName = loc?.name else {
            return
         }
         self.placeName = validName
         guard let validAddress = loc?.location?.address1, let validCity = loc?.location?.city, let validState = loc?.location?.state, let validZipcode = loc?.location?.zip_code else {
            return
         }
         self.placeAddress = "\(validAddress), \(validCity), \(validState), \(validZipcode)"
         
         guard let validPrice = loc?.price else {
            return
         }
         self.price = validPrice

         guard let validPhone = loc?.display_phone else {
            return
         }
         self.phone = validPhone
         
         guard let validRating = loc?.rating else {
            return
         }
         self.rating = validRating
////         print("@@@@@")
////         print(locationManager)
////         locationManager.requestLocation()
//         if let location = locationManager.location {
//             print(location)
//             print(location.latitude)
//             print(location.longitude)
//         }
      } catch {
         print(error)
      }

   }
   

   
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
            Text(String(rating))
            Text(price)
            Text(phone)
            Text(placeAddress).frame(width: 300, height: 150, alignment: .leading)
            
            Spacer()
         }
            .frame(width: 300, height: 400)
            .onAppear {
               chooseContent()
               performRequest()
            }
         Button {
            chooseContent()
            performRequest()
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

