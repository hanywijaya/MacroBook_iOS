import SwiftUI

struct SwipeableRowView<Content: View>: View {

    let onDelete: () -> Void
    let content: () -> Content

    @State private var offset: CGFloat = 0

    private let deleteWidth: CGFloat = 80
    private let swipeThreshold: CGFloat = 50

    init(
        onDelete: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.onDelete = onDelete
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .trailing) {

            // MARK: - Delete Button

            Button {
                withAnimation(.easeOut) {
                    onDelete()
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(.white)
                    .frame(width: deleteWidth)
                    .frame(maxHeight: .infinity)
                    .contentShape(Rectangle())
            }
            .background(.red)
            .buttonStyle(.plain)

            // MARK: - Main Content

            content()
                .offset(x: offset)
                .gesture(
                    DragGesture(minimumDistance: 15)
                        .onChanged { value in
                            let translation = value.translation.width

                            if translation < 0 {
                                offset = max(translation, -deleteWidth)
                            } else {
                                offset = min(0, -deleteWidth + translation)
                            }
                        }
                        .onEnded { value in

                            withAnimation(.easeOut) {

                                if value.translation.width < -swipeThreshold {
                                    offset = -deleteWidth
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}
