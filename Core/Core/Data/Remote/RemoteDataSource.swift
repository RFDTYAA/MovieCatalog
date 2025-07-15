import Foundation
import Combine
import Alamofire

public protocol RemoteDataSourceProtocol {
  func fetchPopular() -> AnyPublisher<[MovieResponse], Error>
  func fetchDetail(id: Int) -> AnyPublisher<MovieDetailResponse, Error>
}

public class RemoteDataSource: RemoteDataSourceProtocol {
  private let api: TMDBAPIProtocol
  
  public init(api: TMDBAPIProtocol) { self.api = api }
  
  public func fetchPopular() -> AnyPublisher<[MovieResponse], Error> {
    return AF.request(api.popularURL())
      .publishDecodable(type: MovieListResponse.self)
      .value()
      .map(\.results)
      .mapError { $0 as Error }
      .eraseToAnyPublisher()
  }
  
  public func fetchDetail(id: Int) -> AnyPublisher<MovieDetailResponse, Error> {
    return AF.request(api.detailURL(id: id))
      .publishDecodable(type: MovieDetailResponse.self)
      .value()
      .mapError { $0 as Error }
      .eraseToAnyPublisher()
  }
}
