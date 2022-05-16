//
//  ItemScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI
import MapKit
import Kingfisher
import AlertToast
import CoreLocation
import Contacts

struct ItemScreen: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.334_900,
                                       longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    @EnvironmentObject var mainViewModel : MainViewModel
    @State var imageSelection = 0
    @State var showToastSuccess = false
    @State var toastMessage = ""
    @State var annotations : [LandmarkPin] = [
    ]
    @State private var directions: [String] = []
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .top) {
                    TabView(selection: $imageSelection) {
                        if ((mainViewModel.currentLandmark?.images.count) != 0) {
                            ForEach(mainViewModel.currentLandmark?.images ?? [], id: \.self) { image in
                                KFImage(URL(string: "https://diplom-app-skinxcheg.herokuapp.com?id=\(image)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 330)
                                    .cornerRadius(10)
                            }
                        } else {
                            ForEach((1...3), id: \.self) {number in
                                KFImage(URL(string: "http://placehold.jp/25/FF5F94/ffffff/\(Int(UIScreen.main.bounds.width - (30 - CGFloat(10 * number))))x330.png"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 330)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 300)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .cornerRadius(10)
                    
                    VStack {
                        Spacer()
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(mainViewModel.currentLandmark?.name ?? "")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 16))
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Image("location")
                                        .resizable()
                                        .frame(width: 13, height: 15)
                                        .aspectRatio(contentMode: .fit)
                                    Text(mainViewModel.currentLandmark?.address ?? "")
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                    Spacer(minLength: 0)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .frame(width: 220, height: 100)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            Spacer()
                            VStack(spacing: 5) {
                                if mainViewModel.currentLandmark?.price != 0 {
                                    Text("₽\(mainViewModel.currentLandmark?.price ?? 0)")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18))
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 10)
                                        .background(Color("darkblueColor"))
                                        .cornerRadius(10)
                                    Text("за билет")
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                        .padding(.top, 5)
                                } else {
                                    Text("Бесплатно")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 5)
                                        .background(Color("darkblueColor"))
                                        .cornerRadius(10)
                                }
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
                        Text(mainViewModel.currentLandmark?.landmarkDescription ?? "")
                            .fontWeight(.regular)
                            .foregroundColor(Color("darkblueColor"))
                            .font(.system(size: 14))
                        
//                        Map(coordinateRegion: $region,
//                            interactionModes: [.all],
//                            showsUserLocation: true,
//                            userTrackingMode: .constant(.follow),
//                            annotationItems: annotations) {
//                            MapAnnotation(coordinate: $0.coordinate) {
//                                Image(systemName: "signpost.right.fill")
//                                    .foregroundColor(.red)
//                                    .font(.system(size: 25))
//                            }
//                        }
                        MapView(directions: $directions, currentLandmark: $mainViewModel.currentLandmark, locationManager: $mainViewModel.locationManager)
                            .frame(height: 230)
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                }
                Spacer()
                HStack {
                    Button {
                        if mainViewModel.favouritesLandmarks.contains(where: {$0.id == mainViewModel.currentLandmark!.id}) {
                            showToastSuccess = true
                            toastMessage = "Объект убран из избранного"
                            mainViewModel.favouritesLandmarks = mainViewModel.favouritesLandmarks.filter(){$0.id != mainViewModel.currentLandmark!.id}
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showToastSuccess = false
                                toastMessage = ""
                            }
                        } else {
                            showToastSuccess = true
                            toastMessage = "Объект добавлен в избранное"
                            mainViewModel.favouritesLandmarks.append(mainViewModel.currentLandmark!)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showToastSuccess = false
                                toastMessage = ""
                            }
                        }
                        try? UserDefaults.standard.set(object: mainViewModel.favouritesLandmarks, forKey: "favouritesLandmarks")
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("pinkColor"))
                            .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                            .overlay(
                                Image(systemName: mainViewModel.favouritesLandmarks.contains(where: {$0.id == mainViewModel.currentLandmark!.id}) ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 3)
                                ,
                                alignment: .center
                            )
                    }

                    Spacer()
                    Button {
                        withAnimation {
                            mainViewModel.screen = "OrderScreen"
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width - 95, height: 50)
                            .foregroundColor(Color("pinkColor"))
                            .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                            .overlay(
                                Text("Купить билет")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                ,
                                alignment: .center
                            )
                    }

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
                        mainViewModel.screen = mainViewModel.prevScreen
                    } label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .overlay(
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .bold, design: .default))
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
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            )
                    }
                }
                    .padding(.top, 40)
                    .padding(.horizontal, 25)
                , alignment: .top
            )
        }
        .toast(isPresenting: $showToastSuccess, duration: 2, tapToDismiss: true, alert: {
            AlertToast(displayMode: .hud, type: .complete(.green), subTitle: toastMessage)
        }, onTap: {
           //onTap would call either if `tapToDismis` is true/false
           //If tapToDismiss is true, onTap would call and then dismis the alert
        }, completion: {
           //Completion block after dismiss
        })
        .onAppear {
        }
    }
}

struct LandmarkPin: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        ItemScreen()
    }
}

struct MapView: UIViewRepresentable {

  typealias UIViewType = MKMapView

  @Binding var directions: [String]
  @Binding var currentLandmark : Landmark?
  @Binding var locationManager : LocationManager

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }

  func makeUIView(context: Context) -> MKMapView {
      let mapView = MKMapView()
      mapView.delegate = context.coordinator
      
      let lat = CLLocationDegrees(currentLandmark!.latitude ?? 0.0)
      let lon = CLLocationDegrees(currentLandmark!.longitude ?? 0.0)
      print("Lat: \(lat), Lon: \(lon)")
      let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 750, longitudinalMeters: 750)
      mapView.setRegion(region, animated: true)
      
      let p1Annotation = MKPointAnnotation()
      p1Annotation.coordinate = locationManager.lastLocation?.coordinate ?? CLLocationCoordinate2D()
      p1Annotation.title = "Ваша позиция"
      
      print(locationManager.lastLocation)
      
      let p1 = MKPlacemark(coordinate: locationManager.lastLocation?.coordinate ?? CLLocationCoordinate2D())

      // Boston
      let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat , longitude: lon))
      let p2Annotation = MKPointAnnotation()
      p2Annotation.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: lon)
      p2Annotation.title = currentLandmark?.name ?? ""

      print(p1, p2)
      
      let request = MKDirections.Request()
      request.source = MKMapItem(placemark: p1)
      request.destination = MKMapItem(placemark: p2)
      request.transportType = .automobile

      let directions = MKDirections(request: request)
      directions.calculate { response, error in
        guard let route = response?.routes.first else { return }
        mapView.addOverlay(route.polyline)
        mapView.addAnnotations([p1Annotation, p2Annotation])
        mapView.setVisibleMapRect(
          route.polyline.boundingMapRect,
          edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
          animated: true)
        self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
      }
      return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 5
      return renderer
    }
  }
}
