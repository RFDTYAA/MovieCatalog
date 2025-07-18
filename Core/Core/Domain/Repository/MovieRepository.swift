import Combine
import Foundation
import Shared

public protocol MovieRepository {
  func fetchPopularMovies() -> AnyPublisher<[Movie], Error>
  func fetchMovieDetail(id: Int) -> AnyPublisher<Movie, Error>
  func getFavoriteMovies()   -> AnyPublisher<[Movie], Error>
  func addToFavorite(movie: Movie)
  func removeFromFavorite(id: Int)
}
