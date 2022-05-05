//
//  MainScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 02.05.2022.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        ZStack {
            VStack {
                Image("mainScreenImage")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 10, height: 330)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 40)
                    .overlay(
                        Button {
                            
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
                                        Image("arrow")
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
                    )
                
                HStack {
                    Text("Популярные")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("darkblueColor"))
                        .font(.system(size: 24))
                    Spacer()
                    Text("Все")
                        .fontWeight(.light)
                        .foregroundColor(Color("darkblueColor"))
                        .font(.system(size: 14))
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Image("image")
                                .resizable()
                                .frame(height: 130)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                            Text("Музей-Заповедник Аксакова")
                                .fontWeight(.bold)
                                .foregroundColor(Color("darkblueColor"))
                                .font(.system(size: 18))
                                .padding(.top, 10)
                            HStack {
                                Image("location")
                                    .resizable()
                                    .frame(width: 13, height: 16)
                                    .aspectRatio(contentMode: .fit)
                                Text("c. Аксаково, ул. Аксаковская")
                                    .fontWeight(.light)
                                    .foregroundColor(Color("darkblueColor"))
                                    .font(.system(size: 14))
                            }
                            .padding(.top, 0)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("blueColor").opacity(0.4))
                                .frame(height: 65)
                            ,
                            alignment: .bottom
                        )
                        .frame(maxWidth: UIScreen.main.bounds.width - 80)
                        .padding(.leading, 30)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mainViewModel.screen = "ItemScreen"
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Image("image")
                                .resizable()
                                .frame(height: 130)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                            Text("Музей-Заповедник Аксакова")
                                .fontWeight(.bold)
                                .foregroundColor(Color("darkblueColor"))
                                .font(.system(size: 18))
                                .padding(.top, 10)
                            HStack {
                                Image("location")
                                    .resizable()
                                    .frame(width: 13, height: 16)
                                    .aspectRatio(contentMode: .fit)
                                Text("c. Аксаково, ул. Аксаковская")
                                    .fontWeight(.light)
                                    .foregroundColor(Color("darkblueColor"))
                                    .font(.system(size: 14))
                            }
                            .padding(.top, 0)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("blueColor").opacity(0.4))
                                .frame(height: 65)
                            ,
                            alignment: .bottom
                        )
                        .frame(maxWidth: UIScreen.main.bounds.width - 80)
                        .padding(.leading, 15)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mainViewModel.screen = "ItemScreen"
                            }
                        }
                    }
                }
                .padding(.leading, -30)
            }
        }
        .padding(.horizontal, 30)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
