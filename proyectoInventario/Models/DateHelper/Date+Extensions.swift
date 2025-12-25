import Foundation

extension Date {

    func formatoCorto() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_PE")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }

    func formatoConHora() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_PE")
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self)
    }
}
