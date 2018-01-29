//
//  UIActiveableType.swift
//  UIActiveableLabel
//
//  Created by Elias Abel on 9/4/15.
//  Copyright © 2015 Meniny Lab. All rights reserved.
//

import Foundation

public enum UIActiveableElement {
    case mention(String)
    case hashtag(String)
    case url(original: String, trimmed: String)
    case custom(String)

    public static func element(with activeType: UIActiveableType, text: String) -> UIActiveableElement {
        switch activeType {
        case .mention: return mention(text)
        case .hashtag: return hashtag(text)
        case .url: return url(original: text, trimmed: text)
        case .custom: return custom(text)
        }
    }
}

public enum UIActiveableType {
    case mention
    case hashtag
    case url
    case custom(pattern: String)

    var pattern: String {
        switch self {
        case .mention: return RegexParser.mentionPattern
        case .hashtag: return RegexParser.hashtagPattern
        case .url: return RegexParser.urlPattern
        case .custom(let regex): return regex
        }
    }
}

extension UIActiveableType: Hashable, Equatable {
    public var hashValue: Int {
        switch self {
        case .mention: return -1
        case .hashtag: return -2
        case .url: return -3
        case .custom(let regex): return regex.hashValue
        }
    }
}

public func ==(lhs: UIActiveableType, rhs: UIActiveableType) -> Bool {
    switch (lhs, rhs) {
    case (.mention, .mention): return true
    case (.hashtag, .hashtag): return true
    case (.url, .url): return true
    case (.custom(let pattern1), .custom(let pattern2)): return pattern1 == pattern2
    default: return false
    }
}
