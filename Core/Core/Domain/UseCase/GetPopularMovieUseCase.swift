import Combine
import Foundation
import Shared

public struct GetPopularMoviesUseCase {
  private let repo: MovieRepository
  public init(repository: MovieRepository) { self.repo = repository }
  public func execute() -> AnyPublisher<[Movie], Error> {
    repo.fetchPopularMovies()
  }
}
