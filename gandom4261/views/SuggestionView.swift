//
//  SuggestionView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/7/21.
//

import SwiftUI
import MapKit
import FirebaseAuth
import Firebase

struct SuggestionView: View {
   
   var category: [String] = ["Restaurant", "Coffee Shop", "Picnic", "Tourist"]
   @State var content: String
   var isGetaway: Bool
   
   let auth = Auth.auth()
   
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
   @State private var user_id: String = ""
   @EnvironmentObject var viewModel: SigninViewModel
   var lat: String = "latitude=33.594100"
   var long: String = "longtitude=-84.286650"
   @State private var desLat: Double = 0.0
   @State private var desLong: Double = 0.0
   var filterRadius: String = ""
   var filterType: String = ""
   var filterPriceLevel: String = ""
   
   
   
   func performRequest() {
      var find = content
      var radius = 10000
      var price = ""
      if isGetaway != true && content == "Restaurant" {
         switch filterRadius {
            case "05 miles":
               radius = 8047
            case "10 miles":
               radius = 16093
            case "15 miles":
               radius = 24140
            case "30 miles":
               radius = 48280
            default:
               radius = 60000
         }
         switch filterType {
            case "Noodle Soup":
               find = "Noodle&Restaurant"
            case "Sushi Bar":
               find = "Sushi&Restaurant"
            case "BBQ":
               find = "BBQ&Restaurant"
            case "Fastfood":
               find = "Fastfood&Restaurant"
            default:
               find = "Restaurant"
         }
         
      }
      if content == "Coffee Shop" {
         find = "Coffee"
      }
      let headers = [
         "Accept": "application/json",
         "Authorization": "Bearer fptQQH-6MKQSd9IuZy8hHZk88BBNgzqbHR-0reJlLnTN6iAQFRewG2br8UvJ6n3h_qmAwGmtXuQCdtrDaoqHoxv-XcFcSTA8B4ycedGr1lb_NJF_J1tN1CgdU_qyYXYx"
      ]
      

      
      
      let yelp_url = "https://api.yelp.com/v3/businesses/search?term=" + find + "&location=Atlanta&"  + lat + "&" + long + "&radius=" + String(radius)
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

         guard let validLat = loc?.coordinates.latitude else {
            return
         }
         self.desLat = validLat
         guard let validLong = loc?.coordinates.longitude else {
            return
         }
         self.desLong = validLong
         print(desLong)

      } catch {
         print(error)
      }

   }
   
   
   
   
   func savePlace(category: String, name: String, phone: String, address: String, price: String, rating: Double, long: Double, lat: Double ) -> Void {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      let db = Firestore.firestore()
      db.collection("gandom").document(name).setData([
         "category": category,
          "name": name,
          "phone": phone,
          "address": address,
          "price": price,
          "rating": rating,
          "user_id": userID,
         "longitude": long,
         "latitude": lat
      ]) { err in
          if let err = err {
              print("Error writing document: \(err)")
          } else {
              print("Document successfully written!")
          }
      }
      
   }

   

   
   func chooseContent() {
      if isGetaway == true {
         self.content = category.randomElement() ?? "boba"
         search = content
      }
   }
   
   func openMap()->Void {
      let url = "http://maps.apple.com/maps?daddr=\(desLat),\(desLong)"
         UIApplication.shared.open(URL(string:url)!)
      
   }
   
   var body: some View {
      VStack {
         VStack(alignment: .leading) {
            Text("Category: \(content)")
               .fontWeight(.bold).font(.title)
            Text(placeName).font(.title2).fontWeight(.bold)
            HStack {
               Text("Rating: ").fontWeight(.bold)
               Text(String(rating))
            }
            HStack {
               Text("Price Level: ").fontWeight(.bold)
               Text(price)
            }
            HStack {
               Text("Phone: ").fontWeight(.bold)
               Text(phone)

            }
            HStack(alignment: .top) {
               Text("Address: ").fontWeight(.bold)
               Text(placeAddress).onTapGesture {
                  openMap()
               }
               
            }
            
            
            Spacer()
         }
            .frame(width: 300, height: 400)
            .onAppear {
               chooseContent()
               performRequest()
            }
         
         
         Button {
            savePlace(category: content,name: placeName, phone: phone, address: placeAddress, price: price, rating: rating, long: desLong, lat: desLat)
         } label: {
            ZStack {
               RoundedRectangle(cornerRadius: 15)
                  .stroke(Color.green)
                  .frame(width: 160, height: 50, alignment: .center)
               
               Text("Save")
                  .font(.title2)
                  .foregroundColor(Color.green)
                  .frame(width: 160, height: 50)
                  .cornerRadius(15)
            }
            
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

