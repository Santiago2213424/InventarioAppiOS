import SwiftUI

struct LoginView: View {

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

            ScrollView {
                VStack {

                    Spacer(minLength: 35)

                    Image("imageninicio")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 180)
                        .clipped()
                        .cornerRadius(12)

                    Text("Inicia sesión")
                        .font(.system(size: 26, weight: .bold))
                        .padding(.top, 8)

                    Text("Accede a tu cuenta para continuar")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 4)

                    CustomTextField(
                        icon: "email",
                        placeholder: "Correo electrónico",
                        text: $email,
                        isSecure: false
                    )
                    .padding(.top, 24)

                    CustomTextField(
                        icon: "lock",
                        placeholder: "Contraseña",
                        text: $password,
                        isSecure: true,
                        showToggle: true,
                        mostrarPassword: $mostrarPassword
                    )
                    .padding(.top, 16)

                    Button {
                        onLoginSuccess()
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
                    .padding(.top, 12)

                    NavigationLink {
                        RecuperarContrasenaView()
                    } label: {
                        Text("¿Olvidaste tu contraseña?")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 10)

                    Spacer(minLength: 30)
                }
                .frame(maxWidth: 370)
            }
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(
                onLoginSuccess: {
                }
            )
        }
    }
}
