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
                    .stroke(lineWidth: 6)
                    .foregroundColor(Color.white.opacity(0.9))
                    .frame(width: 40, height: 40)
                
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 40, height: 40)
                    .animation(.easeInOut(duration: 0.5), value: progress)
                if isDownloaded{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.white)
//                        .padding(.trailing, 4)
//                        .padding(.top, 4)
                }
                
            }
            
        }
    
    }
    
    // Function to simulate download progress
    
}

#Preview {
    CircularProgressView(
        progress: .constant(40.0),
        isDownloaded: .constant(true)
    )
}
