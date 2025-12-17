import SwiftUI

struct MenuCard: View {

    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 4) {
            Text(icon)
                .font(.system(size: 32))

            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 6)
        .padding(.bottom, 8)
    }
}
