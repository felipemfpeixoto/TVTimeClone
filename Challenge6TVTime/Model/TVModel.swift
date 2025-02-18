import Foundation

// MARK: - Welcome
class Welcome: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
//    init(page: Int, totalPages: Int, totalResults: Int) {
//        self.page = page
//        self.totalPages = totalPages
//        self.totalResults = totalResults
//    }
}

extension Welcome {
    static func loadFromBundle() -> Welcome? {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Erro: Arquivo data.json não encontrado no bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let welcome = try decoder.decode(Welcome.self, from: data)
            return welcome
        } catch {
            print("Erro ao carregar e decodificar data.json: \(error)")
            return nil
        }
    }
}

// MARK: - Result
struct TVShow: Codable, Equatable {
    
    static private let imageUrlPrefix = "https://image.tmdb.org/t/p/w500"
    
    let backdropPath: String
    let id: Int
    let name, originalName, overview, posterPath: String
    let mediaType: String
    let adult: Bool
    let originalLanguage: String
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
    
    private func fullImagePath(for image:String?)->URL? {
        guard let image = image,
              let url = URL(string: Self.imageUrlPrefix+image) else {return nil}
        return url
    }
    
    static func ==(lhs: TVShow, rhs: TVShow) -> Bool {
        return lhs.id == rhs.id
    }
}


