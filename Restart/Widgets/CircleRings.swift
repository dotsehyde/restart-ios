//
//  CircleRings.swift
//  Restart
//
//  Created by Benjamin on 09/04/2022.
//

import SwiftUI

struct CircleRings: View {
    var shapeColor:Color
    var shapeOpacity:Double
    var hasAnimation:Bool
    @State private var isAnimated:Bool=false
    var body: some View {
        ZStack{
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity),lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
                .scaleEffect(hasAnimation ? isAnimated ? 1.2 : 0.8 : 1)
                .animation(.easeInOut(duration: 5)
                    .repeatForever(),value: hasAnimation ? isAnimated : false)
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity),lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: isAnimated ? 0:10)
        .opacity(isAnimated ? 1 :0)
        .scaleEffect(isAnimated ? 1 : 0.5)
        .animation(.easeOut(duration: 1),value: isAnimated)
        .onAppear(perform: {
            isAnimated=true
        })
        
    }
}

struct CircleRings_Previews: PreviewProvider {
    static var previews: some View {
        CircleRings(shapeColor: .gray, shapeOpacity: 0.2,hasAnimation: true)
    }
}
