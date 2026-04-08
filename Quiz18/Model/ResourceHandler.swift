import Foundation
import Combine

struct Resource {
    var resourceName: String
    var resourceExtension: String
}

class ResourceHandler: ObservableObject {
    static let questionsResource = Resource(resourceName: "Questions", resourceExtension: "json")
    static let gameHistoryResource = Resource(resourceName: "GameHistory", resourceExtension: "json")
    
    // MARK: Public Interface
    public func loadResource<T: Decodable>(
        ofType type: T.Type,
        from resource: String,
        withExtension fileExtension: String = "json"
    ) -> T? {
        if let document = loadResourceFromDocumentDirectory(ofType: type, from: resource, withExtension: fileExtension) {
            return document
        } else {
            if let resourceFromBundle = loadResourceFromBundle(ofType: type, from: resource, withExtension: fileExtension) {
                return resourceFromBundle
            } else {
                return nil
            }
        }
    }
    
    public func saveResource<T: Codable>(
        _ newData: T,
        to resource: String,
        withExtension fileExtension: String = "json"
    ) {
        var data: [T] = []
        
        if let existingData = loadResourceFromDocumentDirectory(ofType: [T].self, from: resource, withExtension: fileExtension) {
            data.append(contentsOf: existingData)
        }
        
        data.append(newData)
        
        do {
            let encoded = try JSONEncoder().encode(data)
            let url = documentsDirectoryURL(forResource: resource, withExtension: fileExtension)
            try encoded.write(to: url, options: .atomic)
        } catch {
            fatalError("Unable to save resource to \(resource).\(fileExtension)")
        }
    }
    
    // MARK: Private functions
    private func loadFromURL<T: Decodable>(_ type: T.Type, url: URL) -> T? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return try? JSONDecoder().decode(type, from: data)
    }
    
    private func documentsDirectoryURL(forResource resource: String, withExtension fileExtension: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(resource)
            .appendingPathExtension(fileExtension)
    }
    
    private func loadResourceFromBundle<T: Decodable>(
        ofType type: T.Type,
        from resource: String,
        withExtension fileExtension: String
    ) -> T? {
        guard let url = Bundle.main.url(forResource: resource, withExtension: fileExtension) else {
            return nil
        }
        
        return loadFromURL(type, url: url)
    }
    
    private func loadResourceFromDocumentDirectory<T: Decodable>(
        ofType type: T.Type,
        from resource: String,
        withExtension fileExtension: String
    ) -> T? {
        let url = documentsDirectoryURL(forResource: resource, withExtension: fileExtension)
        
        return loadFromURL(type, url: url)
    }
}
