//
//  Favourites.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI
import Kingfisher

struct FavouritesScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        VStack {
            
            ZStack {
                
                VStack {
                    HStack {
                        Text("Избранное")
                            .fontWeight(.bold)
                            .font(.system(size: 32))
                            .foregroundColor(Color("darkblueColor"))
                        Spacer()
                    }
                    
                    if mainViewModel.favouritesLandmarks.count > 0 {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20) {
                                ForEach(mainViewModel.favouritesLandmarks, id: \.id) { landmark in
                                    // MARK: Item
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
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .background(Color("blueColor").opacity(0.2))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            mainViewModel.currentLandmark = landmark
                                            mainViewModel.prevScreen = "Favourites"
                                            mainViewModel.screen = "ItemScreen"
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        Spacer()
                        Image("onBoardingImage2")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height / 4)
                            .aspectRatio(contentMode: .fit)
                        Text("Избранные достопримечательности не найдены")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .foregroundColor(Color("darkblueColor"))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 150)
                    }
                    Spacer()
                }
                .padding(.top, 50)
            
            }
        
        }
        .padding(.horizontal, 30)
        .padding(.top, 50)
    }
}

struct Favourites_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesScreen()
    }
}
