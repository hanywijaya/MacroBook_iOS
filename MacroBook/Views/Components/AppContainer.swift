//
//  AppContainer.swift
//  MacroBook
//
//  Created by Hany Wijaya on 26/06/26.
//

import SwiftUI

struct AppContainer<Content: View>: View {
    let color: Color
    @ViewBuilder let content: Content

    var body: some View {
        ZStack {
            Color(color)
                .ignoresSafeArea()

            content
        }
    }
}
