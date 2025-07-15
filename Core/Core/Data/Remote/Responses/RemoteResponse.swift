import Foundation

// JADIKAN PUBLIC
public struct MovieListResponse: Codable {
    public let results: [MovieResponse]
}

// JADIKAN PUBLIC BESERTA SEMUA PROPERTINYA
public struct MovieResponse: Codable {
    public let id: Int
    public let title: String
    public let poster_path: String?
    public let overview: String?
    public let release_date: String?
    public let vote_average: Double?
}

// JADIKAN PUBLIC BESERTA SEMUA PROPERTINYA
public struct MovieDetailResponse: Codable {
    public let id: Int
    public let title: String
    public let poster_path: String?
    public let overview: String?
    public let release_date: String?
    public let vote_average: Double?
    public let genres: [Genre]

    // Struct di dalamnya juga harus public
    public struct Genre: Codable {
        public let id: Int
        public let name: String
    }
}
