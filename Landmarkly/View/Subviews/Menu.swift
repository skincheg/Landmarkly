//
//  Menu.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        // MARK: Footer
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 60, height: 60)
            .shadow(color: Color("blueColor").opacity(0.8), radius: 5, x: 0, y: 2)
            .overlay(
                HStack {
                    Button {
                        withAnimation(.spring()) {
                            mainViewModel.screen = "MainScreen"
                        }
                    } label: {
                        Image("home")
                    }
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            mainViewModel.screen = "Tickets"
                        }
                    } label: {
                        Image("tickets")
                    }
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            mainViewModel.screen = "Favourites"
                        }
                    } label: {
                        Image("bookmark")
                    }
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            mainViewModel.screen = "CabinetScreen"
                        }
                    } label: {
                        Image("user1")
                    }

                }
                    .padding(.horizontal, 30)
            )
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 80)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
