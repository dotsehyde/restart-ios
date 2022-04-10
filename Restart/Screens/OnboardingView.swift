//
//  Onboarding.swift
//  Restart
//
//  Created by Benjamin on 09/04/2022.
//

import SwiftUI

struct Onboarding: View {
    @AppStorage("isNewUser") var newUser: Bool=true
    @State private var buttonWidth:Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset:CGFloat = 0
    @State private var isAnimated:Bool = false
    @State private var imageOffset:CGSize = .zero
    @State private var indicatorOpacity:Double = 1.0
    @State private var headerText:String = "Share."
    let hapticFeedback = UINotificationFeedbackGenerator()
    var body: some View {
        
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all)
            VStack(spacing:20){
                Spacer()
                //MARK: - Hearder
                VStack {
                    Text(headerText).font(.system(size: 60.0)).fontWeight(.heavy).foregroundColor(.white)
                        .transition(.opacity
                        )
                        .id(headerText)
                    Text("""
                        It's not how much we give but
                        how much love we put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light).foregroundColor(.white).multilineTextAlignment(.center).padding(.horizontal,10)
                }
                .opacity(isAnimated ? 1 : 0)
                .offset(y:isAnimated ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimated)
                //MARK: - Body
                ZStack{
                    
                    CircleRings(shapeColor: .white, shapeOpacity: 0.2,hasAnimation: false)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width/5))
                        .animation(.easeOut(duration: 0.6),value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimated ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimated).offset(x:imageOffset.width).gesture(DragGesture().onChanged({ gesture in
                            if abs(gesture.translation.width) <= 150 {
                            imageOffset=gesture.translation
                            withAnimation(.linear(duration: 0.5)) {
                                headerText="Give."
                                indicatorOpacity=0
                            }
                            }
                        })
                            .onEnded({ _ in
                                imageOffset = .zero
                                withAnimation(.linear(duration: 0.5)){
                                    
                                    headerText="Share."
                                    indicatorOpacity=1
                                }
                            })
                        ).animation(.easeOut(duration: 0.6), value: imageOffset)
                }.overlay(Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight)).foregroundColor(.white).offset(y:20)
                    .opacity(isAnimated ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimated)
                    .opacity(indicatorOpacity), alignment: .bottom)
                
                Spacer()
                //MARK: - Footer
                ZStack{
                    Capsule().fill(.white.opacity(0.2))
                    Capsule().fill(.white.opacity(0.2)).padding(8)
                    HStack{
                        Capsule().fill(Color("ColorRed")).frame(width: 80+buttonOffset)
                        Spacer()
                    }
                    Text("Get Started").font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold).offset(x:20)
                    HStack {
                        ZStack{
                            Circle().fill(Color("ColorRed"))
                            Circle().fill(.black.opacity(0.15)).padding(8)
                            Image(systemName: "chevron.right.2").font(.system(size:24,weight: .bold))
                            
                        }.foregroundColor(.white).frame(width: 80, height: 80, alignment: .center)
                            .offset(x:buttonOffset)
                            .gesture (
                                DragGesture()
                                    .onChanged({ gesture in
                                        if(gesture.translation.width>0 && buttonOffset <= buttonWidth - 80){
                                            buttonOffset=gesture.translation.width;
                                        }
                                        //
                                    })
                                    .onEnded({ _ in
                                        withAnimation(Animation.easeOut(duration: 0.4)){
                                            if(buttonOffset > buttonWidth/2){
                                                buttonOffset = buttonWidth-80
                                                playSound(sound: "chimeup", type: "mp3")
                                                hapticFeedback.notificationOccurred(.success)
                                                newUser = false;
                                            }else{
                                                hapticFeedback.notificationOccurred(.warning)
                                                buttonOffset=0;
                                            }
                                        }
                                        
                                    })
                                
                            )
                        Spacer()
                    }
                }
                .frame(width:buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimated ? 1 : 0)
                .offset(y: isAnimated ? 0 : 40)
                .animation(.easeOut(duration: 1),value:isAnimated)
                
            }
        }.onAppear(perform: {
            isAnimated=true
        }).preferredColorScheme(.dark)
        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
