//
//  EmbeddedColorWell.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/17/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

/// Quote: https://github.com/trozware/swiftui-mac/blob/master/SwiftUI-Mac/UI%20Samples/EmbeddedColorWell.swift

import SwiftUI
import Combine

struct EmbeddedColorWell: NSViewRepresentable {
    @Binding var selectedColor: NSColor

    class Coordinator: NSObject {
        var embedded: EmbeddedColorWell
        var subscription: AnyCancellable?

        init(_ embedded: EmbeddedColorWell) {
            self.embedded = embedded
        }

        // Observe KVO compliant color property on NSColorWell object.
        // Update the selectedColor property on EmbeddedColorWell as needed.
        func changeColor(colorWell: NSColorWell) {
            subscription = colorWell
                .publisher(for: \.color, options: .new)
                .sink { color in
                    DispatchQueue.main.async {
                        self.embedded.selectedColor = color
                    }
            }
        }
    }

    func makeCoordinator() -> EmbeddedColorWell.Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSColorWell {
        let colorWell = NSColorWell(frame: .zero)
        colorWell.color = selectedColor
        context.coordinator.changeColor(colorWell: colorWell)
        return colorWell
    }

    func updateNSView(_ nsView: NSColorWell, context: Context) {
    }
}

struct EmbeddedColorWell_Previews: PreviewProvider {
    @State static var color: NSColor = .black
    static var previews: some View {
        EmbeddedColorWell(selectedColor: $color)
    }
}
