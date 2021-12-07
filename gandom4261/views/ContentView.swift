//
//  ContentView.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/6/21.
//

import SwiftUI

struct ContentView: View {

   @EnvironmentObject var viewModel: SigninViewModel
    var body: some View {
       NavigationView {
          if viewModel.signedIn {
             //MARK: - MAIN SCREEN GOES HERE
             
             VStack {

                
                CategoryView()
             }
             

          } else {
             //SearchLocationView()
             SignInView()
          }
          
       }.onAppear {
          viewModel.signedIn = viewModel.isSignedIn
       }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
