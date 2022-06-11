//
//  VideoScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 11.06.2022.
//

import SwiftUI
import AVKit
import YouTubePlayerKit

struct VideoScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        
        YouTubePlayerView("https://www.youtube.com/watch?v=RwvM2232VMc") { state in
            // Overlay ViewBuilder closure to place an overlay View
            // for the current `YouTubePlayer.State`
            switch state {
            case .idle:
                ProgressView()
            case .ready:
                EmptyView()
            case .error(let error):
                Text(verbatim: "YouTube player couldn't be loaded")
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(
            Button {
                withAnimation(.spring()) {
                    mainViewModel.screen = "OnBoardingScreen"
                }
            } label: {
                Text("Пропустить")
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
                .padding(.bottom, 50)
                .padding(.trailing, 10)
            
            ,
            alignment: .bottomTrailing
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 205) {
                withAnimation(.spring()) {
                    mainViewModel.screen = "OnBoardingScreen"
                }
            }
        }
    }
}

struct VideoScreen_Previews: PreviewProvider {
    static var previews: some View {
        VideoScreen()
    }
}
