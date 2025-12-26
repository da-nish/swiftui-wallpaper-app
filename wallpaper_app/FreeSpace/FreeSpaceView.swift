
//
//  ContentView.swift
//  wallpaper_app
//
//  Created by PropertyShare on 24/12/25.
//


//
//  ContentView.swift
//  wallpaper_app
//
//  Created by PropertyShare on 24/12/25.
//

import SwiftUI

struct FreeSpaceView: View {
    var body: some View {
        ZStack {
//            GridBackgroundView()
            ScrollableGridBackgroundView()
            // Your main content goes here
//            Text("Hello, SwiftUI!")
//                .font(.largeTitle)
//                .foregroundColor(.black)
        }
    }
}



struct ScrollableGridBackgroundView: View {
    let gridSize: CGFloat = 20  // Size of the grid cells
    @State private var offset = CGSize.zero // Tracks the scroll offset

    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            GeometryReader { geometry in
                ZStack {
                    // Draw horizontal grid lines
                    ForEach(0..<Int(geometry.size.height / gridSize) + 1, id: \.self) { i in
                        Path { path in
                            let yPosition = CGFloat(i) * gridSize
                            path.move(to: CGPoint(x: 0, y: yPosition))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: yPosition))
                        }
                        .stroke(Color.green.opacity(0.8), lineWidth: 0.5)
                    }
                    
                    // Draw vertical grid lines
                    ForEach(0..<Int(geometry.size.width / gridSize) + 1, id: \.self) { i in
                        Path { path in
                            let xPosition = CGFloat(i) * gridSize
                            path.move(to: CGPoint(x: xPosition, y: 0))
                            path.addLine(to: CGPoint(x: xPosition, y: geometry.size.height))
                        }
                        .stroke(Color.blue.opacity(0.8), lineWidth: 0.5)
                    }
                    
                    // Optional: Diagonal grid lines (this is just for fun)
                    ForEach(0..<Int(geometry.size.height / gridSize) + 1, id: \.self) { i in
                        Path { path in
                            let position = CGFloat(i) * gridSize
                            path.move(to: CGPoint(x: position, y: 0))
                            path.addLine(to: CGPoint(x: 0, y: position))
                        }
                        .stroke(Color.gray.opacity(0.9), lineWidth: 0.5)
                    }
                    
                    ForEach(0..<Int(geometry.size.width / gridSize) + 1, id: \.self) { i in
                        Path { path in
                            let position = CGFloat(i) * gridSize
                            path.move(to: CGPoint(x: position, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: position))
                        }
                        .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Updating the offset as the user drags
                            self.offset = CGSize(width: value.translation.width, height: value.translation.height)
                        }
                        .onEnded { _ in
                            // Reset the offset when dragging ends (if needed)
                        }
                )
            }
            .frame(width: 5000, height: 5000)  // Larger than screen to enable scrolling
        }
        .edgesIgnoringSafeArea(.all)
    }
}



struct GridBackgroundView: View {
    let gridSize: CGFloat = 20  // Size of the grid cells
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw horizontal grid lines
                ForEach(0..<Int(geometry.size.height / gridSize), id: \.self) { i in
                    Path { path in
                        let yPosition = CGFloat(i) * gridSize
                        path.move(to: CGPoint(x: 0, y: yPosition))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: yPosition))
                    }
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                }
                
                // Draw vertical grid lines
                ForEach(0..<Int(geometry.size.width / gridSize), id: \.self) { i in
                    Path { path in
                        let xPosition = CGFloat(i) * gridSize
                        path.move(to: CGPoint(x: xPosition, y: 0))
                        path.addLine(to: CGPoint(x: xPosition, y: geometry.size.height))
                    }
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FreeSpaceView()
}
