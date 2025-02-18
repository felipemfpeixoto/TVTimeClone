//
//  TVShowsManager.swift
//  Challenge6TVTime
//
//  Created by Felipe on 17/02/25.
//

import Foundation
import CodableExtensions

@Observable
class TVShowsManager: Codable {
    
    static let shared = (try? TVShowsManager.load()) ?? TVShowsManager()
    
    var watchedTvShow: [TVShow] = []
    
    var planningTvShow: [TVShow] = []
    
    private init() {}
    
    func addWatched(_ tvShow: TVShow) {
        watchedTvShow.append(tvShow)
    }
    
    func removeWatched(_ tvShow: TVShow) {
        if let index = watchedTvShow.firstIndex(of: tvShow) {
            watchedTvShow.remove(at: index)
        }
    }
    
    func addPlanned(_ tvShow: TVShow) {
        planningTvShow.append(tvShow)
    }
    
    func removePlanned(_ tvShow: TVShow) {
        if let index = planningTvShow.firstIndex(of: tvShow) {
            planningTvShow.remove(at: index)
        }
    }
}
