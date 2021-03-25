//
//  Article.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import Foundation

struct Article: Decodable, Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
    
    struct Metadata: Decodable {
        let creationTime: String
    }
    
    struct Author: Decodable {
        struct Avatar: Decodable {
            let imageUrl: String
        }
        
        let authorName: String
        let authorAvatar: Avatar
    }
    
    let id: String
    let metaData: Metadata
    let title: String
    let imageUrl: String
    let isSaved: Bool
    let isLiked: Bool
    let likesCount: Int
    let category: String
    let author: Author
    
    public var creationDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let date = formatter.date(from: metaData.creationTime)
        formatter.dateStyle = .medium
        return formatter.string(from: date ?? Date())
    }
    
    public var coverImageNSURL: NSURL {
        NSURL(string: imageUrl)!
    }
    
    public var authorAvatarNSURL: NSURL? {
        NSURL(string: author.authorAvatar.imageUrl)
    }
}
