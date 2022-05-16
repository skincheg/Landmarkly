//
//  Tickets.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 05.05.2022.
//

import SwiftUI

struct Tickets: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        VStack {
            
            ZStack {
                
                VStack {
                    HStack {
                        Text("Купленные билеты")
                            .fontWeight(.bold)
                            .font(.system(size: 32))
                            .foregroundColor(Color("darkblueColor"))
                        Spacer()
                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            // MARK: Item
                            VStack(alignment: .leading, spacing: 5) {
                                Image("image")
                                    .resizable()
                                    .frame(height: 140)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                Text("Памятник погибшим в ВОВ")
                                    .fontWeight(.bold)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("darkblueColor"))
                                HStack {
                                    Image("tickets")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 12, height: 16)
                                    Text("29.08.2022 18:30")
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("darkblueColor"))
                                        .font(.system(size: 13))
                                    Spacer()
                                    Text("₽150")
                                        .fontWeight(.bold)
                                        .font(.system(size: 13))
                                        .foregroundColor(Color("darkblueColor"))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width - 60, height: 200)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("blueColor").opacity(0.2))
                            .cornerRadius(10)
                            
                        }
                    }
                }
                .padding(.top, 50)
            }
        
        }
        .padding(.horizontal, 30)
        .padding(.top, 50)
    }
}

struct Tickets_Previews: PreviewProvider {
    static var previews: some View {
        Tickets()
    }
}
