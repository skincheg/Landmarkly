//
//  CabinetScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI

struct CabinetScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        ZStack {
            Image("lk")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 60)
            Button {
                withAnimation(.spring()) {
                    mainViewModel.screen = "OnBoardingScreenLogin"
                }
            } label: {
                Text("Exit")
                    .frame(width: 100, height: 30)
                    .background(
                        Capsule()
                            .foregroundColor(.white)
                    )
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
