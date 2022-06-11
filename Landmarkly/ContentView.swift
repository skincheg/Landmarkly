//
//  ContentView.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 01.05.2022.
//

import SwiftUI
import PermissionsSwiftUILocation

struct ContentView: View {
    @StateObject var mainViewModel : MainViewModel = MainViewModel()
    @State var isShowHeader = true
    @State var isShowModal = true
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { value in
                    VStack {
                        if (mainViewModel.user == nil) {
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
                        } else {
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
                            if mainViewModel.screen == "OrderScreen" {
                                OrderScreen()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                    .padding(.bottom, 100)
                                    .environmentObject(mainViewModel)
                            }
                            if mainViewModel.screen == "PaymentScreen" {
                                PaymentScreen()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                    .environmentObject(mainViewModel)
                            }
                            if mainViewModel.screen == "AllLandmarks" {
                                AllLandmarks()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                    .environmentObject(mainViewModel)
                            }
                        }
                    }
                    .id(1)
                    .onChange(of: mainViewModel.screen) { newValue in
                        withAnimation(.spring()) {
                            value.scrollTo(1, anchor: .top)
                        }
                    }
                }
            }
            
            if mainViewModel.screen != "ItemScreen" && mainViewModel.screen != "OnBoardingScreen" && mainViewModel.screen != "OnBoardingScreenLogin" && mainViewModel.screen != "RegisterScreen" && mainViewModel.screen != "OrderScreen" && mainViewModel.screen != "PaymentScreen" && mainViewModel.screen != "AllLandmarks" {
                Menu()
                    .environmentObject(mainViewModel)
            }
            
            if mainViewModel.screen != "ItemScreen" && mainViewModel.screen != "OnBoardingScreen" && mainViewModel.screen != "OnBoardingScreenLogin" && mainViewModel.screen != "RegisterScreen" && mainViewModel.screen != "OrderScreen" && mainViewModel.screen != "PaymentScreen" && mainViewModel.screen != "AllLandmarks" && mainViewModel.screen != "CabinetScreen" {
                HStack {
                    Image("profile-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("С возвращением ✋")
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 12))
                        Text(mainViewModel.user?.name ?? "")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .foregroundColor(Color("darkblueColor"))
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 60)
                .background(Capsule().foregroundColor(.white))
                .position(x: UIScreen.main.bounds.width / 2 - 5, y: 65)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .preferredColorScheme(.light)
        .JMModal(showModal: $isShowModal, for: [.location])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
