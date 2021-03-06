//
//  MainViewModel.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import Foundation
import Alamofire

class MainViewModel : ObservableObject {
    @Published var isRegister = true
    @Published var landmarks : [Landmark] = []
    @Published var orders : [Order] = []
    @Published var currentLandmark : Landmark?
    @Published var email : String = "skinxcheg@icloud.com"
    @Published var password : String = "123123"
    @Published var name : String = "Артур"
    @Published var user : User? = try? UserDefaults.standard.get(objectType: User.self, forKey: "user")
    @Published var screen = "VideoScreen"
    @Published var prevScreen = ""
    @Published var favouritesLandmarks : [Landmark] = try! (UserDefaults.standard.get(objectType: [Landmark].self, forKey: "favouritesLandmarks") ?? [])
    @Published var locationManager = LocationManager()
    @Published var date = Date()
    @Published var numberOfTickets = 1
    @Published var showDiscount = false
    
    private let url = "http://194.67.104.237:3000"
    
    init() {
        screen = user == nil ? "VideoScreen" : "MainScreen"
    }
    
    func register(success: @escaping() -> Void, error: @escaping(_ errors: [Error]) -> Void) {
        let parameters: Parameters = [
            "email": email.lowercased(),
            "password": password,
            "name": name
        ]
        AF.request(getUrl(path: "/register"), method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: Login.self) { res in
                print(res.value)
                if res.value?.errors.count != 0 {
                    error(res.value?.errors ?? [])
                    return
                }
                
                self.user = res.value?.user
                try? UserDefaults.standard.set(object: self.user, forKey: "user")
                success()
            }
    }
    
    func login(success: @escaping() -> Void, error: @escaping(_ errors: [Error]) -> Void) {
        let parameters: Parameters = [
            "email": email.lowercased(),
            "password": password
        ]
        AF.request(getUrl(path: "/login"), method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: Login.self) { res in
                print(res.value)
                if res.value?.errors.count != 0 {
                    error(res.value?.errors ?? [])
                    return
                }
                
                self.user = res.value?.user
                try? UserDefaults.standard.set(object: self.user, forKey: "user")
                success()
            }
    }
    
    func landmarksList(success: @escaping() -> Void, error: @escaping() -> Void) {
        AF.request(getUrl(path: "/landmarks/list"), method: .get)
            .responseDecodable(of: LandmarkData.self) { res in
                self.landmarks = res.value?.landmarks ?? []
            }
    }
    
    
    func getUrl(path: String) -> String {
        return url+path
    }
    
    func buyLandmark(success: @escaping() -> Void, error: @escaping(_ errors: [Error]) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY"
        let parameters: Parameters = [
            "id": currentLandmark?.landmarkID ?? "",
            "price": currentLandmark?.price ?? "",
            "date": dateFormatter.string(from: date),
            "userId": user?.userID ?? "",
            "count": numberOfTickets + 1,
        ]
        AF.request(getUrl(path: "/landmarks/buy"), method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: OrderData.self) { res in
                print(res.value)
                if res.value?.errors.count != 0 {
                    error(res.value?.errors ?? [])
                    return
                }
                
//                self.user = res.value?.user
//                try? UserDefaults.standard.set(object: self.user, forKey: "user")
                success()
            }
    }
    
    func orderList(success: @escaping() -> Void, error: @escaping() -> Void) {
        AF.request(getUrl(path: "/landmarks/order/list?userId=\(user?.userID ?? 0)"), method: .get)
            .responseDecodable(of: OrdersData.self) { res in
                print(res)
                self.orders = res.value?.orders ?? []
            }
    }
}

// MARK: - LandmarkData
struct LandmarkData: Codable {
    let landmarks: [Landmark]
}

// MARK: - OrdersData
struct OrdersData: Codable {
    let orders: [Order]
}

// MARK: - Landmark
struct Landmark: Codable, Identifiable {
    let id: String
    let landmarkID: Int
    let name: String
    let price: Int
    let landmarkDescription, address: String
    let latitude, longitude : Double?
    let v: Int
    let images: [String]
    let popular : Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case landmarkID = "id"
        case name, price, images, latitude, longitude, popular
        case landmarkDescription = "description"
        case address
        case v = "__v"
    }
}

// MARK: - Login
struct Login: Codable {
    let user: User?
    let errors: [Error]
}

// MARK: - Error
struct Error: Codable {
    let value: String?
    let msg, param, location: String
}

// MARK: - User
struct User: Codable {
    let userID: Int
    let name, email, password, id: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name, email, password
        case id = "_id"
        case v = "__v"
    }
}

// MARK: - OrderData
struct OrderData: Codable {
    let order: Order?
    let errors: [Error]
}

// MARK: - Order
struct Order: Codable {
    let orderID, landmarkID, price: Int
    let date: String
    let userID, count: Int
    let id: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case orderID = "id"
        case landmarkID = "landmarkId"
        case price, date
        case userID = "userId"
        case count
        case id = "_id"
        case v = "__v"
    }
}
