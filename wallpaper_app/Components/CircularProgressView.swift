//
//  CircularProgressView.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//

import SwiftUICore
import SwiftUI



struct CircularProgressView: View {
     // Progress value between 0 and 1
    @Binding var progress: Float
    @Binding var isDownloaded: Bool
    
    var body: some View {
        VStack {
            
            ZStack {
                Circle()
                    .fill(.white.opacity(0.9))
                    
                    
//                    .stroke(lineWidth: 4)
//                    .foregroundColor(Color.white.opacity(0.9))
                
                Circle()
                        .stroke(
                            Color.blue.opacity(0.2),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.5), value: progress)
                if isDownloaded{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.blue)
                }
            }
            
            
            
            .shadow(radius: 0)
        }
        
    
    }
    
    // Function to simulate download progress
    
}

#Preview {
    CircularProgressView(
        progress: .constant(0.3),
        isDownloaded: .constant(false)
    )
}
