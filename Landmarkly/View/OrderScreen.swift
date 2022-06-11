//
//  OrderScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 10.05.2022.
//

import SwiftUI
import Kingfisher

struct OrderScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2022, month: calendar.component(.month, from: Date()), day: calendar.component(.day, from: Date()))
        let endComponents = DateComponents(year: 2022, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    @State var numberOfTickets = 0
    var body: some View {
        VStack {
            HStack {
                Text("Ваш заказ")
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkblueColor"))
                    .font(.system(size: 28))
                
                Spacer()
            }
            
            // MARK: Item
            VStack(alignment: .leading, spacing: 5) {
                KFImage(URL(string: "http://194.67.104.237:3000?id=\(mainViewModel.currentLandmark?.images[0] ?? "")"))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 80, height: 140)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                Text(mainViewModel.currentLandmark?.name ?? "")
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .foregroundColor(Color("darkblueColor"))
                HStack {
                    Image("location")
                        .resizable()
                        .frame(width: 13, height: 15)
                        .aspectRatio(contentMode: .fit)
                    Text(mainViewModel.currentLandmark?.address ?? "")
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
            
            DatePicker(
                "Дата и время",
                selection: $mainViewModel.date,
                 in: dateRange,
                 displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding(.top, 30)
            .environment(\.locale, Locale.init(identifier: "ru_RU"))
            
            HStack {
                Text("Количество билетов")
                
                Spacer()
                
                Picker("Количество билетов", selection: $mainViewModel.numberOfTickets) {
                    ForEach((1..<10)) {
                        Text("\($0)")
                    }
                }
            }
            
            Button {
                withAnimation {
                    mainViewModel.screen = "PaymentScreen"
                }
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .foregroundColor(Color("pinkColor"))
                    .shadow(color: Color("pinkColor").opacity(0.4), radius: 5, x: 0, y: 2)
                    .overlay(
                        Text("Оплатить")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        ,
                        alignment: .center
                    )
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 170)
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(
            HStack {
                Button {
                    withAnimation(.spring()) {
                        mainViewModel.screen = "ItemScreen"
                    }
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
            }
                .padding(.top, 40)
                .padding(.horizontal, 25)
            , alignment: .top
        )
    }
}

struct OrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderScreen()
    }
}
