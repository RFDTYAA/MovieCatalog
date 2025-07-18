import Foundation

public struct MovieListResponse: Codable {
    public let results: [MovieResponse]
}

public struct MovieResponse: Codable {
    public let id: Int
    public let title: String
    public let poster_path: String?
    public let overview: String?
    public let release_date: String?
    public let vote_average: Double?
}

public struct MovieDetailResponse: Codable {
    public let id: Int
    public let title: String
    public let poster_path: String?
    public let overview: String?
    public let release_date: String?
    public let vote_average: Double?
    public let genres: [Genre]

    public struct Genre: Codable {
        public let id: Int
        public let name: String
    }
}
