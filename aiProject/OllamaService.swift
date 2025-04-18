// код с подключением ollama локально... дл] запуска в терминал ollama serve/run mistral

import Foundation

actor OllamaService {
    static let shared = OllamaService()

    func sendMessage(_ prompt: String) async -> String? {
        guard let url = URL(string: "http://localhost:11434/api/generate") else {
            print("❌ Invalid URL")
            return nil
        }

        let requestBody: [String: Any] = [
            "model": "mistral",
            "prompt": prompt,
            "stream": false
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let response = json["response"] as? String {
                return response.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                print("❌ Invalid response format")
            }
        } catch {
            print("❌ Ollama error: \(error.localizedDescription)")
        }

        return nil
    }
}
