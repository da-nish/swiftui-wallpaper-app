//
//  WallpaperDownloadService.swift
//  wallpaper_app
//
//  Created by PropertyShare on 26/12/25.
//


import UIKit

enum SaveError: Error {
    case invalidImageData
}


final class WallpaperDownloadService {

    static let shared = WallpaperDownloadService()
    private init() {}
    private var validImages: Set<String> = []
    

    // MARK: - Keys
    private let downloadedKey = "downloadedWallpapers"

    // MARK: - Public API
    
    func isDownloadedBefore(_ value: String) -> Bool{
        return validImages.contains(value)
    }

    /// Call this on app startup (AppDelegate / SceneDelegate)
    func syncDownloadedWallpapers() {
        let savedIDs = downloadedIDs
        let validIDs = savedIDs.filter { fileExists(for: $0) }
        validImages = Set(validIDs)
        
       
        print(savedIDs)
        print(validIDs)
        
        if savedIDs != validIDs {
            UserDefaults.standard.set(validIDs, forKey: downloadedKey)
        }
    }

    /// Save image to device and update persistence
    func saveImage(_ image: UIImage, wallpaperID: String) throws {
        let url = fileURL(for: wallpaperID)

        guard let data = image.jpegData(compressionQuality: 1.0) else {
            throw SaveError.invalidImageData
        }

        try data.write(to: url, options: .atomic)

        addDownloadedID(wallpaperID)
    }

    /// Check if wallpaper is downloaded
    func isDownloaded(_ wallpaperID: String) -> Bool {
        guard fileExists(for: wallpaperID) else {
            removeDownloadedID(wallpaperID)
            return false
        }
        return downloadedIDs.contains(wallpaperID)
    }

    /// Optional: delete wallpaper from app storage
    func deleteWallpaper(_ wallpaperID: String) {
        let url = fileURL(for: wallpaperID)
        try? FileManager.default.removeItem(at: url)
        removeDownloadedID(wallpaperID)
    }

    // MARK: - Private Helpers

    private var downloadedIDs: [String] {
        UserDefaults.standard.stringArray(forKey: downloadedKey) ?? []
    }

    private func addDownloadedID(_ id: String) {
        var ids = downloadedIDs
        guard !ids.contains(id) else { return }
        ids.append(id)
        UserDefaults.standard.set(ids, forKey: downloadedKey)
    }

    private func removeDownloadedID(_ id: String) {
        var ids = downloadedIDs
        ids.removeAll { $0 == id }
        UserDefaults.standard.set(ids, forKey: downloadedKey)
    }

    private func fileExists(for id: String) -> Bool {
        FileManager.default.fileExists(atPath: fileURL(for: id).path)
    }

    private func fileURL(for id: String) -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("\(id).jpg")
    }
}
