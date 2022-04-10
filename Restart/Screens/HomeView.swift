//
//  HomeView.swift
//  Restart
//
//  Created by Benjamin on 09/04/2022.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isNewUser") var newUser:Bool=false;
    @State private var isAnimated:Bool=false;
    var body: some View {
        VStack(){
            Spacer()
            
            //Header
            Text("Welcome").font(.system(.largeTitle,design:.rounded)).fontWeight(.bold).foregroundColor(.gray)
            Spacer()
            ZStack{
                CircleRings(shapeColor: .gray, shapeOpacity: 0.1,hasAnimation: false)
                Image("character-2").resizable().scaledToFit().padding().offset(y:isAnimated ? 30 : -25)
                    .animation(
                        .easeInOut(duration: 5)
                        .repeatForever(),value:isAnimated)
            }
            //Body
            Text("""
                 The time that leads to mastery is
                 dependent on the intensity of our focus.
                 """)
            .font(.system(.title3))
            .foregroundColor(.secondary)
            .fontWeight(.light).multilineTextAlignment(.center)
            Spacer()
            //Footer
            ZStack{
                Button(action: {
                    withAnimation(.easeOut(duration: 1)) {
                        playSound(sound: "success", type: "m4a")
                        newUser = true;
                    }
                    
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill").imageScale(.large).foregroundColor(.white)
                    Text("Restart").font(.system(.title3,design: .rounded)).fontWeight(.bold).foregroundColor(.white)
                }).buttonStyle(.borderedProminent).buttonBorderShape(.capsule).controlSize(.large)
//                Capsule().fill(Color("ColorBlue")).frame( height: 70, alignment: .center).padding(.horizontal,50)
//                HStack{
//                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill").foregroundColor(.white)
//                     Text("Restart").font(.system(.title3)).fontWeight(.bold).foregroundColor(.white)
//                }
            }
          
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                isAnimated=true;
            })
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
