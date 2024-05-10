import Foundation

// MARK: - Welcome
struct BookModel: Codable {
    let documents: [Document]
//    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents: String
    let price: Int
    let thumbnail: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case authors, contents, price
        case thumbnail, title
    }
}

//// MARK: - Meta
//struct Meta: Codable {
//    let isEnd: Bool
//    let pageableCount, totalCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case isEnd = "is_end"
//        case pageableCount = "pageable_count"
//        case totalCount = "total_count"
//    }
//}
