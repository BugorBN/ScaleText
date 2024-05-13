//
//  ContentView.swift
//  ScaleText
//
//  Created by Boris Bugor on 13/05/2024.
//

import SwiftUI
import TextEdit

struct ContentView: View {
    @State private var carretWidth = 2.0 as CGFloat
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    @State private var text: String = "Text"
    static let initialTextSize: CGFloat = 40
    
    @State var font = UIFont.systemFont(ofSize: Self.initialTextSize) as CTFont
    
    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                
                currentZoom = value.magnitude - 1
                updateFont()
            }
            .onEnded { value in
                totalZoom += currentZoom
                currentZoom = 0
                updateFont()
            }
    }
    
    private func updateFont() {
        let textSize = Self.initialTextSize * (currentZoom + totalZoom)
        font = UIFont.systemFont(ofSize: textSize)
    }
    
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay {
                let size = textFieldSize()
                
                TextEdit(
                    text: $text,
                    font: $font,
                    carretWidth: $carretWidth
                )
                .frame(width: size.width, height: size.height)
                .foregroundStyle(Color.white)
                .background(Color.black)
                .simultaneousGesture(magnificationGesture)
            }
    }

    private func textFieldSize() -> CGSize {
        text.size(withAttributes: [.font: font])
    }
}

#Preview {
    ContentView()
}
