//
//  ContentView.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 01.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mainViewModel : MainViewModel = MainViewModel()
    @State var isShowHeader = true
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if mainViewModel.screen == "OnBoardingScreen" {
                        OnBoardingScreen()
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "OnBoardingScreenLogin" {
                        OnBoardingScreenLogin()
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "RegisterScreen" {
                        RegisterScreen()
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "MainScreen" {
                        MainScreen()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .padding(.bottom, 100)
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "ItemScreen" {
                        ItemScreen()
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "Favourites" {
                        FavouritesScreen()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .padding(.bottom, 100)
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "CabinetScreen" {
                        CabinetScreen()
                            .environmentObject(mainViewModel)
                    }
                    if mainViewModel.screen == "Tickets" {
                        Tickets()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .padding(.bottom, 100)
                            .environmentObject(mainViewModel)
                    }
                }
            }
            
            if mainViewModel.screen != "ItemScreen" && mainViewModel.screen != "OnBoardingScreen" && mainViewModel.screen != "OnBoardingScreenLogin" && mainViewModel.screen != "RegisterScreen" {
                Menu()
                    .environmentObject(mainViewModel)
            }
            
            if mainViewModel.screen != "ItemScreen" && mainViewModel.screen != "OnBoardingScreen" && mainViewModel.screen != "OnBoardingScreenLogin" && mainViewModel.screen != "RegisterScreen" {
                HStack {
                    Image("profile-image")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("С возвращением ✋")
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 12))
                        Text("Артур Мугинов")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .foregroundColor(Color("darkblueColor"))
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .shadow(color: Color("pinkColor").opacity(0.3), radius: 5, x: 0, y: 2)
                            .overlay(
                                Image("notification")
                            )
                    }

                }
                .frame(width: UIScreen.main.bounds.width - 60)
                .background(Capsule().foregroundColor(.white))
                .position(x: UIScreen.main.bounds.width / 2 - 5, y: 65)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
