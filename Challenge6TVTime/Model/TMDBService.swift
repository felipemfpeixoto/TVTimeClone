//
//  TMDBService.swift
//  Challenge6TVTime
//
//  Created by Felipe on 14/02/25.
//

import Foundation
import UIKit

class TMDBService {
    
    static private let posterUrlPrefix = "https://image.tmdb.org/t/p/w500"
    
    static func requestImage(from path: String) async throws -> UIImage? {
        
        var image: UIImage?
        
        guard let url = URL(string: posterUrlPrefix+path) else {
            print("Path Inválido")
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        let task = try await URLSession.shared.data(for: request)
        
        image = UIImage(data: task.0)
        
        return image
        
    }
}
