//
//  RegisterScreen.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 02.05.2022.
//

import SwiftUI
import AlertToast

struct RegisterScreen: View {
    @EnvironmentObject var mainViewModel : MainViewModel
    @State var showToastError = false
    @State var showToastSuccess = false
    @State var toastMessage = ""
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
                    TextField("E-mail", text: $mainViewModel.email)
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
                        .textInputAutocapitalization(.never)
                }
                
                if mainViewModel.isRegister {
                    HStack {
                        Image("user")
                            .resizable()
                            .frame(width: 20, height: 22)
                            .aspectRatio(contentMode: .fit)
                        TextField("Имя", text: $mainViewModel.name)
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
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                    SecureField("Пароль", text: $mainViewModel.password)
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
                        mainViewModel.register {
                            showToastSuccess = true
                            toastMessage = "Успешная регистрация"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showToastSuccess = false
                                toastMessage = ""
                                mainViewModel.screen = "MainScreen"
                            }
                        } error: { errors in
                            print(errors)
                            showToastError = true
                            toastMessage = errors.first?.msg ?? ""
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showToastError = false
                                toastMessage = ""
                            }
                        }

                    } else {
                        // login
                        mainViewModel.login {
                            showToastSuccess = true
                            toastMessage = "Успешная регистрация"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showToastSuccess = false
                                toastMessage = ""
                                mainViewModel.screen = "MainScreen"
                            }
                        } error: { errors in
                            print(errors)
                            showToastError = true
                            toastMessage = errors.first?.msg ?? ""
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showToastError = false
                                toastMessage = ""
                            }
                        }
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
        .toast(isPresenting: $showToastError, duration: 2, tapToDismiss: true, alert: {
            AlertToast(displayMode: .hud, type: .error(.red), subTitle: toastMessage)
        }, onTap: {
           //onTap would call either if `tapToDismis` is true/false
           //If tapToDismiss is true, onTap would call and then dismis the alert
        }, completion: {
           //Completion block after dismiss
        })
        .toast(isPresenting: $showToastSuccess, duration: 2, tapToDismiss: true, alert: {
            AlertToast(displayMode: .hud, type: .complete(.green), subTitle: toastMessage)
        }, onTap: {
           //onTap would call either if `tapToDismis` is true/false
           //If tapToDismiss is true, onTap would call and then dismis the alert
        }, completion: {
           //Completion block after dismiss
        })
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
