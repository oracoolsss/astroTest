//
//  GistModel.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 01.10.2024.
//

import Foundation
/// Base Gist
// MARK: - BaseGist
struct Gist: Codable {
    let comments: Int
    let commentsURL, commitsURL: String
    let createdAt: String
    let description: String?
    let files: [String: File]
    let forks: [JSONAny]?
    let forksURL, gitPullURL, gitPushURL: String
    let history: [JSONAny]?
    let htmlURL, id, nodeID: String
    /// A GitHub user.
    let owner: OwnerClass?
    let baseGistPublic: Bool
    let truncated: Bool?
    let updatedAt: String
    let url: String
    let user: SimpleUser?

    enum CodingKeys: String, CodingKey {
        case comments
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case createdAt = "created_at"
        case description, files, forks
        case forksURL = "forks_url"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case history
        case htmlURL = "html_url"
        case id
        case nodeID = "node_id"
        case owner
        case baseGistPublic = "public"
        case truncated
        case updatedAt = "updated_at"
        case url, user
    }
}

// MARK: - File
struct File: Codable {
    let filename, language, rawURL: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case filename, language
        case rawURL = "raw_url"
        case size, type
    }
}

/// A GitHub user.
// MARK: - OwnerClass
struct OwnerClass: Codable {
    let avatarURL: String
    let email: String?
    let eventsURL, followersURL, followingURL, gistsURL: String
    let gravatarID: String?
    let htmlURL: String
    let id: Int
    let login: String
    let name: String?
    let nodeID, organizationsURL, receivedEventsURL, reposURL: String
    let siteAdmin: Bool
    let starredAt: String?
    let starredURL, subscriptionsURL, type, url: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case email
        case eventsURL = "events_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case gravatarID = "gravatar_id"
        case htmlURL = "html_url"
        case id, login, name
        case nodeID = "node_id"
        case organizationsURL = "organizations_url"
        case receivedEventsURL = "received_events_url"
        case reposURL = "repos_url"
        case siteAdmin = "site_admin"
        case starredAt = "starred_at"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case type, url
    }
}

/// A GitHub user.
// MARK: - SimpleUser
struct SimpleUser: Codable {
    let avatarURL: String
    let email: String?
    let eventsURL, followersURL, followingURL, gistsURL: String
    let gravatarID: String?
    let htmlURL: String
    let id: Int
    let login: String
    let name: String?
    let nodeID, organizationsURL, receivedEventsURL, reposURL: String
    let siteAdmin: Bool
    let starredAt: String?
    let starredURL, subscriptionsURL, type, url: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case email
        case eventsURL = "events_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case gravatarID = "gravatar_id"
        case htmlURL = "html_url"
        case id, login, name
        case nodeID = "node_id"
        case organizationsURL = "organizations_url"
        case receivedEventsURL = "received_events_url"
        case reposURL = "repos_url"
        case siteAdmin = "site_admin"
        case starredAt = "starred_at"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case type, url
    }
}

typealias GitList = [Gist]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
