//
//  SavedListView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/11/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SavedListView: View {
   @State var docs = [DBdocument]()
   
   func getPlace() {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      print(userID)
      let db = Firestore.firestore()
      
      let docRef = db.collection("gandom")
      let query = docRef.whereField("user_id", isEqualTo: userID).getDocuments {
         (querySnapshot, err) in
         if let err = err {
            print("Error getting documents: \(err)")
         } else {
            for document in querySnapshot!.documents {
               guard let address = document.get("address") else {
                  return
               }
               guard let category = document.get("category") else {
                  return
               }
               guard let name = document.get("name") else {
                  return
               }
               guard let long = document.get("longitude"), let lat = document.get("latitude") else {
                  return
               }
               docs.append(DBdocument(category: category as! String, name: name as! String, addr: address as! String, long: long as! Double, lat: lat  as! Double))
            }
         }
      }
   }
   func openMap(long: Double, lat: Double)->Void {
      let url = "http://maps.apple.com/maps?daddr=\(lat),\(long)"
         UIApplication.shared.open(URL(string:url)!)
      
   }
   var body: some View {
      
      ScrollView() {
         VStack(alignment: .leading) {
            ForEach(docs, id:\.self) {doc in
               VStack(alignment: .leading) {
                  HStack(){
                     Text("category: ").fontWeight(.bold)
                     Text("\(doc.category)")
                  }
                  HStack{
                     Text("name: ").fontWeight(.bold)
                     Text("\(doc.name)")
                  }
                  HStack{
                     Text("address: ").fontWeight(.bold)
                     Text("\(doc.addr)").onTapGesture {
                        openMap(long: doc.long, lat: doc.lat)
                     }
                  }
                  Divider()
               }
            }
         }.padding(.horizontal, 5)
         
         
      }
      .navigationTitle("Saved List")
         .navigationBarTitleDisplayMode(.inline)
         .onAppear {
            getPlace()
         }
      
   }
}

struct SavedListView_Previews: PreviewProvider {
   static var previews: some View {
      SavedListView()
   }
}
