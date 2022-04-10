//
//  ContentView.swift
//  Restart
//
//  Created by Benjamin on 09/04/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isNewUser") var newUser:Bool=true;
    var body: some View {
        ZStack{
            if(newUser){
                Onboarding()
            }else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
