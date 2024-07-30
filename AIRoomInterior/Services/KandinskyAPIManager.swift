import Foundation

class KandinskyAPIManager {
    static let shared = KandinskyAPIManager()
    
    private let apiKey = "506B433A471546C176ECC6856E716DB4"
    private let secretKey = "559A317507AE9A42F6F0E27901F2C594"
    private let baseURL = "https://api-key.fusionbrain.ai/"
    private var modelId: String?
    
    private init() {}
    
    private var authHeaders: [String: String] {
        return [
            "X-Key": "Key \(apiKey)",
            "X-Secret": "Secret \(secretKey)"
        ]
    }
    
    func authenticate(completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: baseURL + "key/api/v1/models")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = authHeaders
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response is HTTPURLResponse else {
                let error = NSError(domain: "",
                                    code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "No response received"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "",
                                    code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    if let modelId = jsonResponse.first?["id"] as? Int {
                        self.modelId = "\(modelId)"
                        completion(.success("\(modelId)"))
                    }
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON response"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func generateImage(prompt: String,
                       width: Int = 1280,
                       height: Int = 1024,
                       completion: @escaping (Result<String, Error>) -> Void) {
        guard let modelId = modelId else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model ID is not set. Please authenticate first."])))
            return
        }
        
        let url = URL(string: baseURL + "key/api/v1/text2image/run")!
        let params: [String: Any] = [
            "type": "GENERATE",
            "numImages": 1,
            "width": width,
            "height": height,
            "generateParams": ["query": prompt]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = authHeaders
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"model_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(modelId)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"params\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        let paramsData = try! JSONSerialization.data(withJSONObject: params, options: [])
        body.append(paramsData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response received"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let uuid = jsonResponse["uuid"] as? String {
                    completion(.success(uuid))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON response"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func checkGenerationStatus(uuid: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let url = URL(string: baseURL + "key/api/v1/text2image/status/\(uuid)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = authHeaders
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response is HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response received"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = jsonResponse["status"] as? String,
                   let images = jsonResponse["images"] as? [String],
                   status == "DONE" {
                    completion(.success(images))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Generation not completed or invalid JSON response"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
