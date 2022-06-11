//
//  OnBoardingScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 02.05.2022.
//

import SwiftUI

struct OnBoardingScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image("logo")
                    .resizable()
                    .frame(width: 38, height: 28)
                Text("Landmarkly")
                    .fontWeight(.bold)
                    .foregroundColor(Color("pinkColor"))
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 40)
            .padding(.leading, 30)
            VStack(alignment: .leading, spacing: 20) {
                Text("Организуем ваше лучшее путешествие в жизни")
                    .fontWeight(.heavy)
                    .foregroundColor(Color("darkblueColor"))
                    .font(.system(size: 32))
                    .lineLimit(4)
                
                Rectangle()
                    .frame(width: 60, height: 1)
                    .cornerRadius(20)
                    .foregroundColor(Color("darkblueColor"))
                
                Text("Ваш идеальный спутник в путешествии.\nВся необходимая информация для путешествия")
                    .font(.system(size: 14))
                    .foregroundColor(Color("darkblueColor"))
                    .fontWeight(.light)
                
                Button(action: {
                    withAnimation(.spring()) {
                        mainViewModel.screen = "OnBoardingScreenLogin"
                    }
                }, label: {
                    Text("Вперёд")
                        .fontWeight(.bold)
                        .padding(.vertical, 17)
                        .padding(.horizontal, 46)
                        .background(Color("pinkColor"))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .shadow(color: Color("pinkColor").opacity(0.8), radius: 5, x: 0, y: 4)
                })
                .padding(.top, 40)
            }
            .padding(.top, 75)
            .padding(.leading, 30)

            Spacer()
            Image("vector")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5, alignment: .bottom)
                .overlay(
                    Image("onBoardingImage1")
                        .resizable()
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 30)
                        .aspectRatio(contentMode: .fit)
                )
        }
        .background(Color("blueColor"))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
        }
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}
