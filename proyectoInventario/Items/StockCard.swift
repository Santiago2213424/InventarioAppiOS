import SwiftUI

struct StockCard: View {

    let emoji: String
    let title: String

    var body: some View {
        VStack(spacing: 10) {

            Text(emoji)
                .font(.system(size: 60))

            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 600)
        .background(Color.AzulOscuro)
        .cornerRadius(16)
        .shadow(radius: 8)
    }
}
