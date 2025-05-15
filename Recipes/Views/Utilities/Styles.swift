import SwiftUI
// MARK: BUTTONS

struct StrokedButtonStyle: ButtonStyle {
    @State private var isAnimating = false
    @Environment(\.colorScheme) private var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .padding()
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            AngularGradient(
                                colors: [.blue, .purple, .pink, .blue],
                                center: .center)
                        )
                        .blur(radius: isAnimating ? 4 : 12)
                        .opacity(0.7)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.5).repeatForever(
                                    autoreverses: true)
                            ) {
                                isAnimating = true
                            }
                        }

                    Capsule()
                        .fill(colorScheme == .light ? .white : .black)
                        .stroke(colorScheme == .light ? .black : .white, lineWidth: 3)
                }
            }
    }
}

struct SelectableButtonModifier: ViewModifier {
    var color: Color
    var secondaryColor: Color
    var isSelected: Bool

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(isSelected ? color.opacity(0.7) : secondaryColor.opacity(0.7))
            )
    }
}

extension View {
    func selectableButton(color: Color, secondaryColor: Color, isSelected: Bool) -> some View {
        self.modifier(SelectableButtonModifier(color: color ,secondaryColor: secondaryColor , isSelected: isSelected))
    }
}
