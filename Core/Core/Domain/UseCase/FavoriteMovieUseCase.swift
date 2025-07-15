import Combine
import Foundation

public struct FavoriteMoviesUseCase {
  private let repo: MovieRepository
  public init(repository: MovieRepository) { self.repo = repository }
  public func getFavorites() -> AnyPublisher<[Movie], Error> {
    repo.getFavoriteMovies()
  }
  public func addFavorite(movie: Movie) { repo.addToFavorite(movie: movie) }
  public func removeFavorite(id: Int)    { repo.removeFromFavorite(id: id) }
}
