//
//  RegisterScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 02.05.2022.
//

import SwiftUI

struct RegisterScreen: View {
    @State var email = ""
    @EnvironmentObject var mainViewModel : MainViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(mainViewModel.isRegister ? "registerScreenImage" : "loginScreenImage")
                .resizable()
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width, height: 250)
                .aspectRatio(contentMode: .fit)
            Text(mainViewModel.isRegister ? "Регистрация" : "Авторизация")
                .fontWeight(.heavy)
                .foregroundColor(Color("darkblueColor"))
                .font(.system(size: 32))
                .padding(.top, 50)
                .padding(.leading, 30)
                .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Image("email")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                    TextField("E-mail", text: $email)
                        .frame(height: 40)
                        .padding(.leading, 5)
                        .foregroundColor(Color("darkblueColor"))
                        .background(
                            Rectangle()
                                .frame(height: 1)
                                .cornerRadius(20)
                                .foregroundColor(Color("darkblueColor"))
                            , alignment: .bottomLeading
                        )
                        .keyboardType(.emailAddress)
                }
                
                if mainViewModel.isRegister {
                    HStack {
                        Image("user")
                            .resizable()
                            .frame(width: 20, height: 22)
                            .aspectRatio(contentMode: .fit)
                        TextField("Имя", text: $email)
                            .frame(height: 40)
                            .padding(.leading, 5)
                            .foregroundColor(Color("darkblueColor"))
                            .background(
                                Rectangle()
                                    .frame(height: 1)
                                    .cornerRadius(20)
                                    .foregroundColor(Color("darkblueColor"))
                                , alignment: .bottomLeading
                            )
                            .keyboardType(.namePhonePad)
                    }
                }
                
                HStack {
                    Image("key")
                        .resizable()
                        .frame(width: 20, height: 22)
                        .aspectRatio(contentMode: .fit)
                    SecureField("Пароль", text: $email)
                        .frame(height: 40)
                        .padding(.leading, 5)
                        .foregroundColor(Color("darkblueColor"))
                        .background(
                            Rectangle()
                                .frame(height: 1)
                                .cornerRadius(20)
                                .foregroundColor(Color("darkblueColor"))
                            , alignment: .bottomLeading
                        )
                }
            }
            .padding(.horizontal, 30)
            Text("Регистрируясь, вы соглашаетесь с **политикой конфиденциальности**")
                .foregroundColor(Color("darkblueColor"))
                .font(.system(size: 14))
                .padding(.leading, 30)
                .padding(.top, 30)
            
            Button(action: {
                withAnimation(.spring()) {
                    if mainViewModel.isRegister {
                        // register
                        mainViewModel.screen = "MainScreen"
                    } else {
                        // login
                        mainViewModel.screen = "MainScreen"
                    }
                }
            }, label: {
                Text("Вперёд")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                    .background(Color("pinkColor"))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .shadow(color: Color("pinkColor").opacity(0.8), radius: 5, x: 0, y: 4)
            })
            .padding(.leading, 30)
            .padding(.top, 30)
            Spacer()
            HStack(spacing: 5) {
                Spacer()
                Text(mainViewModel.isRegister ? "Уже зарегистрирован?": "Еще не зарегистрирован?")
                    .foregroundColor(Color("darkblueColor"))
                    .font(.system(size: 17))

                Button {
                    withAnimation(.spring()) {
                        mainViewModel.isRegister.toggle()
                    }
                } label: {
                    Text(mainViewModel.isRegister ? "**Авторизуйся**" : "**Вперед**")
                        .foregroundColor(Color("darkblueColor"))
                        .font(.system(size: 17))
                }

                Spacer()
            }
            .padding(.bottom, 50)
        }
        .padding(.top, 70)
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
