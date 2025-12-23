import SwiftUI

struct LoginView: View {

    @StateObject private var authVM = AuthViewModel()

    let onLoginSuccess: () -> Void

    @State private var email = ""
    @State private var password = ""
    @State private var mostrarPassword = false

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {

                VStack(spacing: 20) {

                    Spacer(minLength: 30)

                    Image("imageninicio")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 180)
                        .clipped()
                        .cornerRadius(12)

                    Text("Inicia sesión")
                        .font(.system(size: 26, weight: .bold))

                    Text("Accede a tu cuenta para continuar")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }

                ScrollView {
                    VStack(spacing: 12) {

                        CustomTextField(
                            icon: "email",
                            placeholder: "Correo electrónico",
                            text: $email,
                            fieldType: .email
                        )

                        CustomTextField(
                            icon: "lock",
                            placeholder: "Contraseña",
                            text: $password,
                            fieldType: .password,
                            showToggle: true,
                            mostrarPassword: $mostrarPassword
                        )

                        Button {
                            authVM.login(
                                correo: email,
                                password: password
                            ) {
                                onLoginSuccess()
                            }
                        } label: {
                            Text("Iniciar sesión")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top, 24)

                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Crear una cuenta")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.red)
                                .cornerRadius(12)
                        }

                        NavigationLink {
                            RecuperarContrasenaView()
                        } label: {
                            Text("¿Olvidaste tu contraseña?")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.blue)
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.top, 16)
                }
            }
            .frame(maxWidth: 370)
        }
        .alert(
            "Error de inicio de sesión",
            isPresented: $authVM.showErrorAlert
        ) {
            Button("OK") {
                authVM.errorMessage = nil
            }
        } message: {
            Text(authVM.errorMessage ?? "")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView {
                print("Login exitoso")
            }
        }
    }
}
