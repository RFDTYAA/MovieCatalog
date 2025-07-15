import Combine
import Foundation

public struct GetMovieDetailUseCase {
  private let repo: MovieRepository
  public init(repository: MovieRepository) { self.repo = repository }
  public func execute(id: Int) -> AnyPublisher<Movie, Error> {
    repo.fetchMovieDetail(id: id)
  }
}
