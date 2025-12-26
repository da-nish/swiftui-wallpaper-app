//
//  DownloadButton.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//

import SwiftUICore
import SwiftUI



struct DownloadButton: View {
    let onTap: () -> Void
    var body: some View {
        Button(action: { onTap() }){
            HStack {
                Image(systemName: "arrow.down.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                Text("Download")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal, 10)
        }
    }
}
