import SwiftUI

public struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = 0
    var duration = 1.5
    var bounce = false

    public func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedMask(phase: phase).animation(
                    Animation.linear(duration: duration)
                        .repeatForever(autoreverses: bounce)
                )
            )
            .onAppear { phase = 0.8 }
    }

    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat = 0

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black, location: phase),
                            .init(color: .black.opacity(0.3), location: phase + 0.1),
                            .init(color: .black, location: phase + 0.2)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .scaleEffect(3)
                )
        }
    }
}

public extension View {
    @ViewBuilder
    func shimmering(
        duration: Double = 1.5,
        bounce: Bool = false
    ) -> some View {
        modifier(Shimmer(duration: duration, bounce: bounce))
    }
}
