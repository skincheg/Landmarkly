//
//  AllLandmarks.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 11.06.2022.
//

import SwiftUI
import Kingfisher

struct AllLandmarks: View {
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(mainViewModel.landmarks, id: \.id) { landmark in
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
                                        mainViewModel.prevScreen = "AllLandmarks"
                                        mainViewModel.screen = "ItemScreen"
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 50)
                    }
                }
                .padding(.top, 50)
            
            }
        
        }
        .padding(.horizontal, 30)
        .padding(.top, 50)
        .overlay(
            HStack {
                Button {
                    withAnimation(.spring()) {
                        mainViewModel.screen = "MainScreen"
                    }
                } label: {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .overlay(
                            Image("left-arrow")
                                .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 3)
                            ,
                            alignment: .center
                        )
                }
                Spacer()
            }
                .padding(.top, 40)
                .padding(.horizontal, 25)
            , alignment: .top
        )
    }
}

struct AllLandmarks_Previews: PreviewProvider {
    static var previews: some View {
        AllLandmarks()
    }
}
