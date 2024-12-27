//
//  ContentView.swift
//  SlenderRow
//
//  Created by me on 16.12.2024.
//

import SwiftUI


struct ContentView: View {
    @State private var isHorizontal = true
    private var rectangleCount = 7
    private var colors = [Color.red, .blue, .green, .gray, .yellow, .purple, .black]
    
    var body: some View {
        let layout = isHorizontal ? AnyLayout(HStackLayout()) : AnyLayout(DiagonalLayout())
        
        layout {
            ForEach(0..<rectangleCount, id: \.self) { i in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(colors[i])
                    .scaledToFit()
            }
        }
        .onTapGesture {
            withAnimation(.linear) {
                isHorizontal.toggle()
            }
        }
    }
}

struct DiagonalLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions() // View size will be unspecified
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let count = subviews.count
        let height = bounds.height / CGFloat(count)
        
        let wStep = (bounds.width - height) / CGFloat(count - 1)
        for (i, view) in subviews.enumerated() {
            view.place(
                at: .init(
                    x: CGFloat(i) * wStep,
                    y: (bounds.maxY - height) - (height * CGFloat(i))
                ),
                proposal: .init(
                    width: height,
                    height: height
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
