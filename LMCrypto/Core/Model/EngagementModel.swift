//
//  EngagementModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 10/9/2567 BE.
//

import Foundation

struct EngagementModel {
    var liked: Int
    var disLiked: Int
    var comment: Int

    init(liked: Int = 0, disLiked: Int = 0, comment: Int = 0) {
        self.liked = liked
        self.disLiked = disLiked
        self.comment = comment
    }
}

extension EngagementModel: Codable {

    enum CodingKeys: String, CodingKey {
        case liked = "liked"
        case disLiked = "disLiked"
        case comment = "comment"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.liked = try map.decodeIfPresent(Int.self, forKey: .liked) ?? 0
            self.disLiked = try map.decodeIfPresent(Int.self, forKey: .disLiked) ?? 0
            self.comment = try map.decodeIfPresent(Int.self, forKey: .comment) ?? 0
        } catch {
            self = Self()
        }
    }
}
