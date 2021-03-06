//
//  MainScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 02.05.2022.
//

import SwiftUI
import Kingfisher

struct MainScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    @StateObject var locationManager = LocationManager()
    var body: some View {
        ZStack {
            VStack {
                Image("mainScreenImage")
                    .interpolation(.high)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 10, height: 330)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 40)
                    .overlay(
                        Button {
                            mainViewModel.showDiscount = true
                        } label: {
                            HStack {
                                VStack {
                                    Text("Исследуем мир?")
                                        .fontWeight(.bold)
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("darkblueColor"))
                                    Text("получи специальные предложения и скидки")
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("pinkColor"))
                                    .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                                    .overlay(
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.white)
                                            .font(.system(size: 24, weight: .bold, design: .default))
                                            .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 3)
                                        ,
                                        alignment: .center
                                    )

                            }
                            .padding(.horizontal, 15)
                            .frame(width: UIScreen.main.bounds.width - 130, height: 70)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                            .padding(.top, 180)
                        }
                            .frame(width: UIScreen.main.bounds.width - 130, height: 70)
                    )
                
                HStack {
                    Text("Популярные")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("darkblueColor"))
                        .font(.system(size: 24))
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            mainViewModel.prevScreen = "MainScreen"
                            mainViewModel.screen = "AllLandmarks"
                        }
                    } label: {
                        Text("Все")
                            .fontWeight(.light)
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 14))
                    }

                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(mainViewModel.landmarks, id: \.id) { landmark in
                            if (landmark.popular ?? false) {
                                VStack(alignment: .leading, spacing: 0) {
                                    KFImage(URL(string: (landmark.images.first != nil) ? "http://194.67.104.237:3000?id=\(landmark.images.first ?? "")" : "http://placehold.jp/25/FF5F94/ffffff/\(Int(UIScreen.main.bounds.width - 100))x150.png"))
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 100, height: 150)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(10)
                                    HStack {
                                        Text(landmark.name)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("darkblueColor"))
                                            .font(.system(size: 18))
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                    HStack {
                                        Image("location")
                                            .resizable()
                                            .frame(width: 13, height: 16)
                                            .aspectRatio(contentMode: .fit)
                                        Text(landmark.address)
                                            .fontWeight(.light)
                                            .foregroundColor(Color("darkblueColor"))
                                            .font(.system(size: 14))
                                        Spacer()
                                    }
                                    .padding(.top, 0)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("blueColor").opacity(0.4))
                                        .frame(width: UIScreen.main.bounds.width - 70, height: 65)
                                    ,
                                    alignment: .bottom
                                )
                                .frame(maxWidth: UIScreen.main.bounds.width - 70)
                                .padding(.leading, 30)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        mainViewModel.currentLandmark = landmark
                                        mainViewModel.prevScreen = "MainScreen"
                                        mainViewModel.screen = "ItemScreen"
                                    }
                                }
                            }
                        }
                    }
                    .padding(.trailing, 30)
                }
                .padding(.horizontal, -30)
            }
        }
        .padding(.horizontal, 30)
        .onAppear {
            mainViewModel.landmarksList {
                
            } error: {
                
            }

        }
        .sheet(isPresented: $mainViewModel.showDiscount) {
            VStack {
                
                ZStack {
                    
                    VStack {
                        HStack {
                            Text("Специальные предложения для тебя")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .foregroundColor(Color("darkblueColor"))
                            Spacer()
                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20) {
                                ForEach(mainViewModel.landmarks, id: \.id) { landmark in
                                    // MARK: Item
                                    if landmark.price > 0 {
                                        VStack(spacing: 5) {
                                            KFImage(URL(string: (landmark.images.first != nil) ? "http://194.67.104.237:3000?id=\(landmark.images.first ?? "")" : "http://placehold.jp/25/FF5F94/ffffff/\(Int(UIScreen.main.bounds.width - 80))x140.png"))
                                                .resizable()
                                                .frame(width: UIScreen.main.bounds.width - 80, height: 140)
                                                .aspectRatio(contentMode: .fill)
                                                .cornerRadius(10)
                                            HStack {
                                                Text(landmark.name)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 19))
                                                    .foregroundColor(Color("darkblueColor"))
                                                Spacer()
                                            }
                                            HStack {
                                                Image("location")
                                                    .resizable()
                                                    .frame(width: 13, height: 15)
                                                    .aspectRatio(contentMode: .fit)
                                                Text(landmark.address)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("darkblueColor"))
                                                    .font(.system(size: 13))
                                                Spacer()
                                            }
                                            HStack {
                                                Image("tickets")
                                                    .resizable()
                                                    .frame(width: 13, height: 15)
                                                    .aspectRatio(contentMode: .fit)
                                                Text("₽\(landmark.price)")
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("darkblueColor"))
                                                    .font(.system(size: 13))
                                                Spacer()
                                            }
                                        }
                                        .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 10)
                                        .background(Color("blueColor").opacity(0.2))
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            withAnimation(.spring()) {
                                                mainViewModel.currentLandmark = landmark
                                                mainViewModel.prevScreen = "MainScreen"
                                                mainViewModel.screen = "ItemScreen"
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    .padding(.top, 50)
                }
            
            }
            .padding(.horizontal, 20)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
