import CoreData
import Foundation

// Jadikan class ini public agar bisa diakses dari luar modul
public final class CoreDataManager {
    public static let shared = CoreDataManager()
    private init() {}

    // Helper untuk menemukan bundle dari modul Core
    private class var coreBundle: Bundle {
        return Bundle(for: CoreDataManager.self)
    }

    public lazy var container: NSPersistentContainer = {
        let modelName = "Movie_Catalog" // Pastikan nama ini sama persis dengan file .xcdatamodeld

        // Cari model di dalam bundle 'Core'
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
