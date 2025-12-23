import SwiftUI

struct RegisterView: View {

    @StateObject private var authVM = AuthViewModel()

    @State private var nombre = ""
    @State private var apellido = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var repeatPassword = ""

    @State private var showPassword = false
    @State private var showRepeatPassword = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack {

                    Spacer(minLength: 130)

                    VStack {
                        Text("Registro de Usuarios")
                            .font(.system(size: 22, weight: .bold))
                            .padding(16)
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal, 15)

                    VStack(spacing: 12) {

                        CustomTextField(
                            icon: "ic_person",
                            placeholder: "Nombre",
                            text: $nombre,
                            fieldType: .normal
                        )

                        CustomTextField(
                            icon: "ic_person",
                            placeholder: "Apellido",
                            text: $apellido,
                            fieldType: .normal
                        )

                        CustomTextField(
                            icon: "email",
                            placeholder: "Correo electrónico",
                            text: $correo,
                            fieldType: .email
                        )

                        CustomTextField(
                            icon: "lock",
                            placeholder: "Contraseña",
                            text: $password,
                            fieldType: .password,
                            showToggle: true,
                            mostrarPassword: $showPassword
                        )

                        CustomTextField(
                            icon: "lock",
                            placeholder: "Repetir contraseña",
                            text: $repeatPassword,
                            fieldType: .password,
                            showToggle: true,
                            mostrarPassword: $showRepeatPassword
                        )

                        Button {
                            authVM.register(
                                nombre: nombre,
                                apellido: apellido,
                                correo: correo,
                                password: password,
                                repeatPassword: repeatPassword
                            ) {
                                dismiss()
                            }
                        } label: {
                            if authVM.isLoading {
                                ProgressView()
                            } else {
                                Text("Registrarse")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.top, 8)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal, 16)

                    Spacer(minLength: 30)
                }
                .frame(maxWidth: 370)
            }
        }
        .alert(
            "Error de registro",
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
