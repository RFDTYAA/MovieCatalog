import CoreData
import Foundation

public final class CoreDataManager {
    public static let shared = CoreDataManager()
    private init() {}
    private class var coreBundle: Bundle {
        return Bundle(for: CoreDataManager.self)
    }

    public lazy var container: NSPersistentContainer = {
        let modelName = "Movie_Catalog"
        guard let modelURL = CoreDataManager.coreBundle.url(forResource: modelName, withExtension: "momd") else {
            fatalError("--- KRITIS --- Gagal menemukan Data Model file di dalam bundle Core: \(modelName).momd")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("--- KRITIS --- Gagal membuat model dari URL: \(modelURL)")
        }
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("--- KRITIS --- Gagal memuat Persistent Store: \(error), \(error.userInfo)")
            }
        }
        
        print("✅ Core Data Stack berhasil diinisialisasi secara eksplisit.")
        return container
    }()

    public var context: NSManagedObjectContext {
        return container.viewContext
    }

    public func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Data berhasil disimpan ke Core Data.")
            } catch {
                let nserror = error as NSError
                print("❌ Gagal menyimpan context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
