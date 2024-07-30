import UIKit

class ImageAnalysisManager {
    static let shared = ImageAnalysisManager()
    
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZTQ4OWVmNzctY2Q0Ny00ZGUwLTkzMDktNDM3NWQyY2U3ZTUyIiwidHlwZSI6ImFwaV90b2tlbiJ9.iuCoRvqIDBqkAkoY2Gp0IBU9nV4c5ZWQIC5CA388EuI"
    private let baseUrl = "https://api.edenai.run/v2/image/object_detection"

    private init() {}

    func detectObjects(in image: UIImage, completion: @escaping (Result<ImageAnalisisResposeModel, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "",
                                        code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }

        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: baseUrl)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)",
                         forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)",
                         forHTTPHeaderField: "Authorization")

        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"

        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
        body.appendString("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")

        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"providers\"\r\n\r\n")
        body.appendString("amazon,google\r\n")

        body.appendString("--\(boundary)--\r\n")

        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let jsonResponse = DecodingManager().decodeJSON(type: ImageAnalisisResposeModel.self,
                                                                from: data)
                if let respos = jsonResponse {
                    completion(.success(respos))
                }
                else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON"])
                    completion(.failure(error))
                }
            } 
        }

        task.resume()
    }
}

private extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct DecodingManager {
    func decodeJSON<T: Decodable>(type: T.Type,
                                  from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data else {
            return nil
        }
        do {
            return try decoder.decode(type, from: data)
        } catch {
            print("JSON-decoding error")
            return nil
        }
    }
}
