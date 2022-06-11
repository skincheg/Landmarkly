//
//  CabinetScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI
import MapKit
import Kingfisher

struct CabinetScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 53.656220, longitude: 52.437497), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region, annotationItems: mainViewModel.landmarks) { landmark in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: landmark.latitude ?? 0.0, longitude: landmark.longitude ?? 0.0)) {
                    Image(mainViewModel.currentLandmark?.landmarkID == landmark.landmarkID ? "location-active" : "location")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mainViewModel.currentLandmark = landmark
                            }
                        }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            if mainViewModel.currentLandmark != nil {
                HStack {
                    KFImage(URL(string: (mainViewModel.currentLandmark?.images.first != nil) ? "http://194.67.104.237:3000?id=\(mainViewModel.currentLandmark?.images.first ?? "")" : "http://placehold.jp/25/FF5F94/ffffff/\(Int(UIScreen.main.bounds.width - 80))x140.png"))
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(mainViewModel.currentLandmark?.name ?? "")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .foregroundColor(Color("darkblueColor"))
                        Text(mainViewModel.currentLandmark?.landmarkDescription ?? "")
                            .fontWeight(.thin)
                            .font(.system(size: 11))
                            .foregroundColor(Color("darkblueColor"))
                            .lineLimit(6)
                        
                        Button {
                            withAnimation(.spring()) {
                                mainViewModel.prevScreen = "CabinetScreen"
                                mainViewModel.screen = "ItemScreen"
                            }
                        } label: {
                            Text("Подробнее")
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
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .frame(width: UIScreen.main.bounds.width - 50, height: 170)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(color: Color("pinkColor").opacity(0.8), radius: 5, x: 0, y: 2)
                )
                .padding(.top, 50)
            }
        }
        .padding(.horizontal, 30)
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct CabinetScreen_Previews: PreviewProvider {
    static var previews: some View {
        CabinetScreen()
    }
}
