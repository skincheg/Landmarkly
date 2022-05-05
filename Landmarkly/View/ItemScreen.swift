//
//  ItemScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI
import MapKit

struct ItemScreen: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.334_900,
                                       longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .top) {
                    Image("itemImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 330)
                        .cornerRadius(10)
                    
                    VStack {
                        Spacer()
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Музей-Заповедник Аксакова")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("darkblueColor"))
                                    .font(.system(size: 20))
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
                                .frame(width: 220, height: 100)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            Spacer()
                            VStack(spacing: 5) {
                                Text("₽150")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                    .background(Color("darkblueColor"))
                                    .cornerRadius(10)
                                Text("в день")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color("darkblueColor"))
                                    .font(.system(size: 14))
                                    .padding(.top, 5)
                            }
                                .frame(width: 90, height: 100)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 380)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Описание")
                                .fontWeight(.bold)
                                .foregroundColor(Color("darkblueColor"))
                                .font(.system(size: 24))
                            Spacer()
                        }
                        Text("Lorem Ipsum - это текст-, часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн. Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время, программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.")
                            .fontWeight(.regular)
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 14))
                        
                        Map(coordinateRegion: $region)
                            .frame(height: 230)
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                }
                Spacer()
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("pinkColor"))
                        .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                        .overlay(
                            Image("bookmark-white")
                                .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 3)
                            ,
                            alignment: .center
                        )
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: UIScreen.main.bounds.width - 95, height: 50)
                        .foregroundColor(Color("pinkColor"))
                        .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                        .overlay(
                            Text("Забронировать")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                            ,
                            alignment: .center
                        )
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 15)
            }
            .padding(.top, 20)
            .ignoresSafeArea(.all, edges: .all)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 15)
            .overlay(
                HStack {
                    Button {
                        mainViewModel.screen = "MainScreen"
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
                    Button {
                        
                    } label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .overlay(
                                Image("notification")
                            )
                    }
                }
                    .padding(.top, 40)
                    .padding(.horizontal, 25)
                , alignment: .top
            )
        }
    }
}

struct ItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        ItemScreen()
    }
}
