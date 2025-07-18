import Foundation
import Combine
import Shared

public class MovieRepositoryImpl: MovieRepository {
    private let remote: RemoteDataSourceProtocol
    private let local: LocalDataSourceProtocol

    public init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }

    public func fetchPopularMovies() -> AnyPublisher<[Movie], Error> {
        return remote.fetchPopular()
            .map { responses in
                return responses.map { ModelMapper.map(response: $0) }
            }
            .eraseToAnyPublisher()
    }

    public func fetchMovieDetail(id: Int) -> AnyPublisher<Movie, Error> {
        return remote.fetchDetail(id: id)
            .map { detailResponse in
                return ModelMapper.map(detail: detailResponse)
            }
            .eraseToAnyPublisher()
    }

    public func getFavoriteMovies() -> AnyPublisher<[Movie], Error> {
        return local.getFavorites()
            .map { entities in
                return entities.map { ModelMapper.map(entity: $0) }
            }
            .eraseToAnyPublisher()
    }

    public func addToFavorite(movie: Movie) {
        local.addFavorite(movie)
    }

    public func removeFromFavorite(id: Int) {
        local.removeFavorite(id: id)
    }
}
