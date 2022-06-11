//
//  PaymentScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 10.05.2022.
//

import SwiftUI
import LoaderUI

struct PaymentScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    @State var status = "Проверка оплаты, ожидайте"
    var body: some View {
        VStack {
            Image("onBoardingImage2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 100)
            Text(status)
                .fontWeight(.bold)
                .foregroundColor(Color("darkblueColor"))
                .font(.system(size: 21))
                .padding(.top, 15)
            BallScaleRippleMultiple()
                .frame(width: 70, height: 70)
        }
        .onAppear {
            withAnimation(.spring()) {
                mainViewModel.buyLandmark {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        status = "Оплата принята, спасибо"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            mainViewModel.screen = "MainScreen"
                        }
                    }
                } error: { errors in
                    print(errors)
                }
            }
        }
    }
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen()
    }
}
