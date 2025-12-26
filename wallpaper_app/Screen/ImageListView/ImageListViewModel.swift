//
//  ImageListViewModel.swift
//  wallpaper_app
//
//  Created by PropertyShare on 24/12/25.
//

import Foundation

import Foundation
import Combine

struct ImageResponse: Codable {
    let images: [ImageItem]
    let hasMore: Bool
}

struct ImageItem: Codable {
    let imageId: Int
    let imageUrl: String
    let downloadUrl: String
}

class ImageDownloadState: Identifiable, ObservableObject, Hashable {
    let imageId: Int
    let imageUrl: URL
    let downloadUrl: URL
    @Published var downloadProgress: Float = 0.0  // Progress (0.0 to 1.0)
    @Published var isDownloaded: Bool = false  // Flag to check if it's downloaded
    @Published var isInProgress: Bool = false  // Flag to check if it's downloaded
    
    init(imageId: Int, imageUrl: URL, downloadUrl: URL, isDownloded: Bool = false) {
        self.imageId = imageId
        self.imageUrl = imageUrl
        self.downloadUrl = downloadUrl
        self.isDownloaded = isDownloded
    }
    // Implementing the hash(into:) method for Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageId)
        hasher.combine(imageUrl)
        hasher.combine(downloadUrl)
    }
    
    // Implementing == for Hashable conformance
    static func == (lhs: ImageDownloadState, rhs: ImageDownloadState) -> Bool {
        return lhs.imageId == rhs.imageId && lhs.imageUrl == rhs.imageUrl && lhs.downloadUrl == rhs.downloadUrl
    }
}


class ImageListViewModel: ObservableObject{
    
    @Published var images: [ImageDownloadState] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var currentPage = 1
    private var hasMore = true
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()
    
    init() {
        WallpaperDownloadService.shared.syncDownloadedWallpapers()
    }
    
    // Load initial set of images
    func loadImages() {
        print("images loading")
        guard !isLoading && hasMore else { return }
        
        isLoading = true
        apiService.fetchImages(page: currentPage) { result in
            self.isLoading = false
            switch result {
            case .success(let response):
// self.images.append(contentsOf: response.images)
                for item in response.images{
                    let img = ImageDownloadState(
                        imageId: item.imageId,
                        imageUrl: URL(string: item.imageUrl)!,
                        downloadUrl: URL(string: item.downloadUrl)!,
                        isDownloded: WallpaperDownloadService.shared.isDownloadedBefore(String(item.imageId))
                    )
                    self.images.append(img)
                }
                self.hasMore = response.hasMore
                self.currentPage += 1
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
