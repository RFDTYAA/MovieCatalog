import Foundation
import Combine

// Jadikan kelas ini public agar bisa diakses oleh SwinjectAssembler
public class MovieRepositoryImpl: MovieRepository {
    private let remote: RemoteDataSourceProtocol
    private let local: LocalDataSourceProtocol

    // Jadikan init public
    public init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }

    public func fetchPopularMovies() -> AnyPublisher<[Movie], Error> {
        return remote.fetchPopular()
            .map { responses in
                // Ubah array [MovieResponse] menjadi array [Movie]
                return responses.map { ModelMapper.map(response: $0) }
            }
            .eraseToAnyPublisher()
    }

    public func fetchMovieDetail(id: Int) -> AnyPublisher<Movie, Error> {
        return remote.fetchDetail(id: id)
            .map { detailResponse in
                // Ubah MovieDetailResponse menjadi Movie
                return ModelMapper.map(detail: detailResponse)
            }
            .eraseToAnyPublisher()
    }

    public func getFavoriteMovies() -> AnyPublisher<[Movie], Error> {
        return local.getFavorites()
            .map { entities in
                // Ubah array [MovieEntity] menjadi array [Movie]
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
