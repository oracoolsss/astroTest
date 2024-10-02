//
//  GistInfo.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gistInfo = try? JSONDecoder().decode(GistInfo.self, from: jsonData)

import Foundation

/// Gist Simple
// MARK: - GistInfo
struct GistInfo: Codable {
    let comments: Int?
    let commentsURL, commitsURL, createdAt: String?
    let description: String?
    let files: [String: GistInfoFile?]?
    /// Gist
    let forkOf: Gist?
    let forks: [Fork]?
    let forksURL, gitPullURL, gitPushURL: String?
    let history: [Commit]?
    let htmlURL, id, nodeID: String?
    /// A GitHub user.
    let owner: SimpleUser?
    let gistInfoPublic, truncated: Bool?
    let updatedAt, url: String?
    let user: String?
    
    enum CodingKeys: String, CodingKey {
        case comments
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case createdAt = "created_at"
        case description, files
        case forkOf = "fork_of"
        case forks
        case forksURL = "forks_url"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case history
        case htmlURL = "html_url"
        case id
        case nodeID = "node_id"
        case owner
        case gistInfoPublic = "public"
        case truncated
        case updatedAt = "updated_at"
        case url, user
    }
}

// MARK: - GistInfoFile
struct GistInfoFile: Codable {
    let content, filename, language, rawURL: String?
    let size: Int?
    let truncated: Bool?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case content, filename, language
        case rawURL = "raw_url"
        case size, truncated, type
    }
}

// MARK: - FileValue
struct FileValue: Codable {
    let filename, language, rawURL: String?
    let size: Int?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case filename, language
        case rawURL = "raw_url"
        case size, type
    }
}

// MARK: - Fork
struct Fork: Codable {
    let createdAt: Date?
    let id: String?
    let updatedAt: Date?
    let url: String?
    /// Public User
    let user: PublicUser?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url, user
    }
}

/// Public User
// MARK: - PublicUser
struct PublicUser: Codable {
    let avatarURL: String
    let bio, blog: String?
    let collaborators: Int?
    let company: String?
    let createdAt: Date
    let diskUsage: Int?
    let email: String?
    let eventsURL: String
    let followers: Int
    let followersURL: String
    let following: Int
    let followingURL, gistsURL: String
    let gravatarID: String?
    let hireable: Bool?
    let htmlURL: String
    let id: Int
    let location: String?
    let login: String
    let name: String?
    let nodeID: String
    let notificationEmail: String?
    let organizationsURL: String
    let ownedPrivateRepos: Int?
    let plan: Plan?
    let privateGists: Int?
    let publicGists, publicRepos: Int
    let receivedEventsURL, reposURL: String
    let siteAdmin: Bool
    let starredURL, subscriptionsURL: String
    let suspendedAt: Date?
    let totalPrivateRepos: Int?
    let twitterUsername: String?
    let type: String
    let updatedAt: Date
    let url: String
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bio, blog, collaborators, company
        case createdAt = "created_at"
        case diskUsage = "disk_usage"
        case email
        case eventsURL = "events_url"
        case followers
        case followersURL = "followers_url"
        case following
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case gravatarID = "gravatar_id"
        case hireable
        case htmlURL = "html_url"
        case id, location, login, name
        case nodeID = "node_id"
        case notificationEmail = "notification_email"
        case organizationsURL = "organizations_url"
        case ownedPrivateRepos = "owned_private_repos"
        case plan
        case privateGists = "private_gists"
        case publicGists = "public_gists"
        case publicRepos = "public_repos"
        case receivedEventsURL = "received_events_url"
        case reposURL = "repos_url"
        case siteAdmin = "site_admin"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case suspendedAt = "suspended_at"
        case totalPrivateRepos = "total_private_repos"
        case twitterUsername = "twitter_username"
        case type
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - Plan
struct Plan: Codable {
    let collaborators: Int
    let name: String
    let privateRepos, space: Int
    
    enum CodingKeys: String, CodingKey {
        case collaborators, name
        case privateRepos = "private_repos"
        case space
    }
}

/// Gist History
// MARK: - GistHistory
struct Commit: Codable {
    let changeStatus: ChangeStatus?
    let committedAt: String?
    let url: String?
    let user: HistorySimpleUser?
    let version: String?
    
    enum CodingKeys: String, CodingKey {
        case changeStatus = "change_status"
        case committedAt = "committed_at"
        case url, user, version
    }
}

// MARK: - ChangeStatus
struct ChangeStatus: Codable {
    let additions, deletions, total: Int?
}

/// A GitHub user.
// MARK: - HistorySimpleUser
struct HistorySimpleUser: Codable {
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
