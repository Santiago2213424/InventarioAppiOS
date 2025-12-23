import SwiftUI

class AuthViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var showErrorAlert = false

    func login(
        correo: String,
        password: String,
        onSuccess: @escaping () -> Void
    ) {
        guard !correo.isEmpty, !password.isEmpty else {
            errorMessage = "Completa todos los campos"
            showErrorAlert = true
            return
        }

        isLoading = true
        errorMessage = nil

        AuthService.shared.login(email: correo, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success:
                    onSuccess()

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorAlert = true
                }
            }
        }
    }

    func register(
        nombre: String,
        apellido: String,
        correo: String,
        password: String,
        repeatPassword: String,
        onSuccess: @escaping () -> Void
    ) {
        guard !nombre.isEmpty,
              !apellido.isEmpty,
              !correo.isEmpty,
              !password.isEmpty,
              !repeatPassword.isEmpty else {
            errorMessage = "Completa todos los campos"
            showErrorAlert = true
            return
        }

        guard password == repeatPassword else {
            errorMessage = "Las contraseñas no coinciden"
            showErrorAlert = true
            return
        }

        isLoading = true
        errorMessage = nil

        AuthService.shared.register(email: correo, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success:
                    onSuccess()

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorAlert = true
                }
            }
        }
    }
}
