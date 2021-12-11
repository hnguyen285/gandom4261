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
   
   func getPlace() {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      print("#####")
      print(userID)
      let db = Firestore.firestore()

      let docRef = db.collection("gandom")
      let query = docRef.whereField("user_id", isEqualTo: userID).getDocuments {
         (querySnapshot, err) in
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     print("This")
                     for document in querySnapshot!.documents {
                         print("\(document.documentID) => \(document.data())")
                     }
                 }
      }
   }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SavedListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedListView()
    }
}
