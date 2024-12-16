//
//  ContentView.swift
//  SlenderRow
//
//  Created by me on 16.12.2024.
//

import SwiftUI


struct ContentView: View {
    @State private var isHorizontal = true
    private var rectangleCount: CGFloat = 7
    
    var body: some View {
        GeometryReader { proxy in
            let range = 0..<Int(rectangleCount)
            let rangeReversed = range.reversed()
            
            let HMargin: CGFloat = 5
            
            ZStack() {
                ForEach(range, id: \.self) { index in
                    let rectangleWidth = proxy.size.width / rectangleCount
                    let rectangleHeight = proxy.size.height / rectangleCount
                    
                    let rectangleWidthH = rectangleWidth - HMargin
                    
                    let reversedIndex = CGFloat(
                        rangeReversed[rangeReversed.index(rangeReversed.startIndex, offsetBy: index)]
                    )
                    
                    let horizontalOffsetX = (reversedIndex * (rectangleWidthH + HMargin))
                    let diagonalOffsetX = reversedIndex * rectangleWidth
                    
                    let horizontalOffsetY = proxy.size.height / 2
                    let diagonalOffsetY = CGFloat(index) * rectangleHeight
                    
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(
                            width: isHorizontal ? rectangleWidthH: rectangleWidth * 2,
                            height: isHorizontal ? rectangleWidth : rectangleHeight)
                        .offset(
                            x: isHorizontal ? horizontalOffsetX : diagonalOffsetX,
                            y: isHorizontal ? horizontalOffsetY : diagonalOffsetY
                        )
                        .foregroundStyle(.blue)
                }
            }
            .animation(.linear, value: isHorizontal)
        }
        .onTapGesture {
            isHorizontal.toggle()
        }
    }
}

#Preview {
    ContentView()
}
