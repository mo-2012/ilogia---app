import SwiftUI

struct OfflineView: View {
    var onRetry: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "101D36")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "wifi.slash")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(Color(hex: "34D399"))

                Text("لا يوجد اتصال بالإنترنت")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Text("يرجى التأكد من اتصال هاتفك بشبكة Wi-Fi أو بيانات الهاتف ثم المحاولة مجدداً.")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Button(action: onRetry) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                        Text("إعادة المحاولة")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
                    .background(Color(hex: "136F58"))
                    .cornerRadius(14)
                }
                .padding(.top, 10)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
