import Foundation

struct ModelMapper {
  static func map(response: MovieResponse) -> Movie {
    .init(id: response.id,
          title: response.title,
          posterPath: response.poster_path,
          overview: response.overview,
          releaseDate: response.release_date,
          rating: response.vote_average)
  }
  static func map(detail: MovieDetailResponse) -> Movie {
    .init(id: detail.id,
          title: detail.title,
          posterPath: detail.poster_path,
          overview: detail.overview,
          releaseDate: detail.release_date,
          rating: detail.vote_average)
  }
  static func map(entity: MovieEntity) -> Movie {
    .init(id: Int(entity.id),
          title: entity.title ?? "",
          posterPath: entity.posterPath,
          overview: entity.overview,
          releaseDate: nil,
          rating: nil)
  }
}
