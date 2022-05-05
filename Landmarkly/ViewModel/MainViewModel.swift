//
//  MainViewModel.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import Foundation

class MainViewModel : ObservableObject {
    @Published var screen = "OnBoardingScreen"
    @Published var isRegister = true
}
