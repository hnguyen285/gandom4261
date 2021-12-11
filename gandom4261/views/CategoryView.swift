//
//  CategoryView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 12/7/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CategoryView: View {
   
   @EnvironmentObject var viewModel: SigninViewModel
   @ObservedObject var categoryModel =  CategoryModel()
   var category: [String] = ["Restaurant", "Coffee Shop", "Picnic", "Tourist"]
   @State var randomCategory: String = ""
   
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
      
      ScrollView(showsIndicators: false) {
         Spacer()
         
         VStack() {
            ForEach(category, id: \.self) {
               CategorySubView(content: $0)
            }
            
         }
         .navigationTitle("Pick a Category")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
            Button {
               viewModel.signOut()
            } label: {
               Text("Sign Out")
               
            }
         }
      }.frame(maxWidth: .infinity, maxHeight: 400)
      
      NavigationLink {
         SuggestionView(content: categoryModel.randomCategory, isGetaway: true)
      } label: {
         ZStack {
            RoundedRectangle(cornerRadius: 10)
               .fill(.red)
               .frame(width: 300, height: 100)
            Text("Last minute get away!")
               .font(.title)
               .foregroundColor(.white)
               .frame(width: 300, height: 100)
         }
      }.onTapGesture {
         getRandomCategory()
      }
      
      Spacer()
      Button {
         getPlace()
      } label: {
         ZStack {
            RoundedRectangle(cornerRadius: 15)
               .stroke(Color.green)
               .frame(width: 160, height: 50, alignment: .center)
            
            Text("Saved list")
               .font(.title2)
               .foregroundColor(Color.green)
               .frame(width: 160, height: 50)
               .cornerRadius(15)
         }
         
      }
      NavigationLink {
         SavedListView()
      } label: {
         ZStack {
            RoundedRectangle(cornerRadius: 15)
               .stroke(Color.green)
               .frame(width: 160, height: 50, alignment: .center)
            
            Text("Go to Saved List")
               .font(.title2)
               .foregroundColor(Color.green)
               .frame(width: 160, height: 50)
               .cornerRadius(15)
         }
      }

      
      Spacer()
   }
   
   func getRandomCategory() -> Void {
      categoryModel.randomCategory = category.randomElement() ?? "boba"
   }
}


struct CategoryView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryView()
   }
}
