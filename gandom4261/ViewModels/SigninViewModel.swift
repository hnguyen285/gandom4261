//
//  SwiftUIView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/6/21.
//

import SwiftUI
import FirebaseAuth

class SigninViewModel: ObservableObject {
   
   let auth = Auth.auth()
   @Published var signedIn = false
   var isSignedIn: Bool {
      return auth.currentUser != nil
   }
   
   func signIn(email: String, password: String) {
      auth.signIn(withEmail: email, password: password) {[weak self] res, err in
         guard res != nil, err == nil else {
            return
         }
         //Success Sign In
         DispatchQueue.main.async {
            self?.signedIn = true
         }
         
      }
   }
   
   func signUp(email: String, password: String) {
      auth.createUser(withEmail: email, password: password) {[weak self] res, err in
         guard res != nil, err == nil else {
            return
         }
         //Success Sign Up
         DispatchQueue.main.async {
            self?.signedIn = true
         }
      }
   }
   
   func signOut() {
      try? auth.signOut()
      self.signedIn = false
   }
}
