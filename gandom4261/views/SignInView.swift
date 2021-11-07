//
//  LoginView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/6/21.
//

import SwiftUI

struct SignInView: View {
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
               .autocapitalization(.none)
               .disableAutocorrection(true)
               .padding()
               .background(Color(.secondarySystemBackground))
               .cornerRadius(15)
            
            HStack {
               Button {
                   viewModel.signIn(email: "phodbgmail.com", password: "123123")
               } label: {
                  ZStack {
                     RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black)
                        .frame(width: 160, height: 50, alignment: .center)
                     
                     Text("Use as a Guest")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .frame(width: 160, height: 50)
                     
                        .cornerRadius(15)
                  }
               }
               
               Button {
                  guard !email.isEmpty, !password.isEmpty else {
                     return
                  }
                  viewModel.signIn(email: email, password: password)
               } label: {
                  Text("Sign In")
                     .font(.title2)
                     .foregroundColor(Color.white)
                     .frame(width: 160, height: 50)
                     .background(Color.green)
                     .cornerRadius(15)
               }
               
            }.padding()
            
            NavigationLink("Create Account", destination: SignUpView())
               .font(.title2)
            
         }
         .padding()
         Spacer()
      }.navigationTitle("Sign In")
         .background(.gray)
   }
   
}

