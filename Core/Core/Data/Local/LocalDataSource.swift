import Combine
import CoreData
import Foundation
import Shared

public protocol LocalDataSourceProtocol {
  func getFavorites() -> AnyPublisher<[MovieEntity], Error>
  func addFavorite(_ movie: Movie)
  func removeFavorite(id: Int)
}

public class LocalDataSource: LocalDataSourceProtocol {
  private let manager: CoreDataManager
  public init(manager: CoreDataManager) { self.manager = manager }

  public func getFavorites() -> AnyPublisher<[MovieEntity], Error> {
    Future { promise in
      let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
      do {
        let items = try self.manager.context.fetch(fetchRequest)
        promise(.success(items))
      } catch {
        promise(.failure(error))
      }
    }.eraseToAnyPublisher()
  }


  public func addFavorite(_ movie: Movie) {
    let e = MovieEntity(context: self.manager.context)
    e.id = Int32(movie.id)
    e.title = movie.title
    e.posterPath = movie.posterPath
    e.overview = movie.overview
    self.manager.saveContext()
  }


  public func removeFavorite(id: Int) {
    let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id==%d", id)
    
    do {
        let items = try self.manager.context.fetch(fetchRequest)
        if let itemToDelete = items.first {
            self.manager.context.delete(itemToDelete)
            self.manager.saveContext()
        }
    } catch {
        print("Gagal menghapus favorit: \(error)")
    }
  }
}
