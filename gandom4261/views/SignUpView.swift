//
//  SignUpView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/6/21.
//

import SwiftUI

struct SignUpView: View {
   @State var email = ""
   @State var password = ""
   @EnvironmentObject var viewModel: SigninViewModel
   var body: some View {
      
      VStack {
         Image("logo")
            .resizable()
            .frame(width:120, height: 120, alignment: .center)
         VStack {
            TextField("Email", text: $email)
               .autocapitalization(.none)
               .disableAutocorrection(true)
               .padding()
               .background(Color(.secondarySystemBackground))
               .cornerRadius(15)
               .padding(.vertical)
            SecureField("Password", text: $password)
               .foregroundColor(Color.black)
               .autocapitalization(.none)
               .disableAutocorrection(true)
               .padding()
               .background(Color(.secondarySystemBackground))
               .cornerRadius(15)
            
            HStack {
               
               
               Button {
                  guard !email.isEmpty, !password.isEmpty else {
                     return
                  }
                  viewModel.signUp(email: email, password: password)
               } label: {
                  Text("Sign Up")
                     .font(.title2)
                     .foregroundColor(Color.white)
                     .frame(width: 160, height: 50)
                     .background(Color.green)
                     .cornerRadius(15)
               }
               
            }.padding()
            
            
            
            
         }
         .padding()
         Spacer()
      }.navigationTitle("Create Account")
         .navigationBarTitleDisplayMode(.inline)
         .background(.gray)
   }
   
}
