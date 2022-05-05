//
//  Favourites.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI

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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            // MARK: Item
                            VStack(alignment: .leading, spacing: 5) {
                                Image("image")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 140)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                Text("Памятник погибшим в ВОВ")
                                    .fontWeight(.bold)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("darkblueColor"))
                                HStack {
                                    Image("location")
                                        .frame(width: 13, height: 15)
                                        .aspectRatio(contentMode: .fit)
                                    Text("c. Аксаково, ул. Аксаковская")
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("blueColor").opacity(0.2))
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Image("image")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 140)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                Text("Памятник погибшим в ВОВ")
                                    .fontWeight(.bold)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("darkblueColor"))
                                HStack {
                                    Image("location")
                                        .frame(width: 13, height: 15)
                                        .aspectRatio(contentMode: .fit)
                                    Text("c. Аксаково, ул. Аксаковская")
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("blueColor").opacity(0.2))
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Image("image")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 140)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                Text("Памятник погибшим в ВОВ")
                                    .fontWeight(.bold)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("darkblueColor"))
                                HStack {
                                    Image("location")
                                        .frame(width: 13, height: 15)
                                        .aspectRatio(contentMode: .fit)
                                    Text("c. Аксаково, ул. Аксаковская")
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("blueColor").opacity(0.2))
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Image("image")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 140)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                Text("Памятник погибшим в ВОВ")
                                    .fontWeight(.bold)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("darkblueColor"))
                                HStack {
                                    Image("location")
                                        .frame(width: 13, height: 15)
                                        .aspectRatio(contentMode: .fit)
                                    Text("c. Аксаково, ул. Аксаковская")
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("blueColor").opacity(0.2))
                            .cornerRadius(10)
                            .padding(.bottom, 100)
                            
                        }
                    }
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
