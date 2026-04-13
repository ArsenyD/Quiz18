import Foundation

final class ResourceHandler {
    // MARK: Public Interface
    /// Loads resource with specified name from either the documents directory or from the bundle.
    public func loadResource<T: Decodable>(
        ofType type: T.Type,
        from resource: Resource
    ) -> T? {
        if let document = loadResourceFromDocumentDirectory(ofType: type, from: resource.name, withExtension: resource.fileExtension) {
            return document
        } else {
            if let resourceFromBundle = loadResourceFromBundle(ofType: type, from: resource.name, withExtension: resource.fileExtension) {
                return resourceFromBundle
            } else {
                return nil
            }
        }
    }
    
    /// Saves an array of data to the documents directory. If the resource with the specified name already exists the new data is appended to the end of the document.
    public func saveResource<T: Codable>(
        _ newData: [T],
        to resource: Resource,
    ) {
        var data: [T] = []
        
        if let existingData = loadResourceFromDocumentDirectory(ofType: [T].self, from: resource.name, withExtension: resource.fileExtension) {
            data.append(contentsOf: existingData)
        }
        
        data.append(contentsOf: newData)
        
        do {
            let encoded = try JSONEncoder().encode(data)
            let url = documentsDirectoryURL(forResource: resource.name, withExtension: resource.fileExtension)
            try encoded.write(to: url, options: .atomic)
        } catch {
            fatalError("Unable to save resource to \(resource.name).\(resource.fileExtension)")
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
