//
//  OnBoardingScreenLogin.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 02.05.2022.
//

import SwiftUI

struct OnBoardingScreenLogin: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Text("Ваша возможность")
                    .foregroundColor(Color("pinkColor"))
                    .fontWeight(.heavy)
                    .font(.system(size: 14))
                Text("Получить доступ к путешествию мечты")
                    .fontWeight(.heavy)
                    .foregroundColor(Color("darkblueColor"))
                    .font(.system(size: 32))
                    .lineLimit(4)
                Rectangle()
                    .frame(width: 60, height: 1)
                    .cornerRadius(20)
                    .foregroundColor(Color("pinkColor"))
                    .padding(.top, 30)
            
            }
            .padding(.leading, 30)
            
            VStack(alignment: .leading, spacing: 15) {
                Button(action: {
                    withAnimation(.spring()) {
                        mainViewModel.screen = "RegisterScreen"
                        mainViewModel.isRegister = true
                    }
                }, label: {
                    HStack(spacing: 15) {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                            .overlay(
                                Image("register")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 25)
                            )
                        Text("Создать аккаунт")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 18))
                    }
                })
                .padding(.leading, 30)
                
                Text("или")
                    .foregroundColor(Color("pinkColor"))
                    .fontWeight(.heavy)
                    .font(.system(size: 24))
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                
                Button(action: {
                    withAnimation(.spring()) {
                        mainViewModel.screen = "RegisterScreen"
                        mainViewModel.isRegister = false
                    }
                }, label: {
                    HStack(spacing: 15) {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                            .overlay(
                                Image("login")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 22)
                            )
                        Text("Войти в аккаунт")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 18))
                    }
                })
                .padding(.leading, 30)

            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.top, 30)
            .padding(.bottom, 110)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
        .ignoresSafeArea(.all, edges: .all)
        .background(
            Image("Ellipse")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .overlay(
                    Image("onBoardingImage2")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height / 3)
                        .aspectRatio(contentMode: .fit)
                ), alignment: .top
        )
        .overlay(
            Button {
                withAnimation(.spring()) {
                    mainViewModel.screen = "MainScreen"
                }
            } label: {
                Text("Войти как гость")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("pinkColor"))
                            .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                    )
            }
                .padding(.top, 50)
                .padding(.trailing, 20)
            
            ,
            alignment: .topTrailing
        )
    }
}

struct OnBoardingScreenLogin_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreenLogin()
    }
}
