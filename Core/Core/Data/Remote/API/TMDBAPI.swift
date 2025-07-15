import Foundation

public protocol TMDBAPIProtocol {
  func popularURL() -> URL
  func detailURL(id: Int) -> URL
}

public struct TMDBAPI: TMDBAPIProtocol {
  private let apiKey: String
  public init(apiKey: String) { self.apiKey = apiKey }
  public func popularURL() -> URL {
    URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1")!
  }
  public func detailURL(id: Int) -> URL {
    URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US")!
  }
}
