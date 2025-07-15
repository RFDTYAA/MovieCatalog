import Combine
import Foundation

public extension URLSession {
  func publisher(for url: URL) -> AnyPublisher<Data, URLError> {
    dataTaskPublisher(for: url)
      .map(\.data)
      .eraseToAnyPublisher()
  }
}
