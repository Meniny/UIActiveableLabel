//
//  Builder.swift
//  UIActiveableLabel
//
//  Created by Elias Abel on 04/09/16.
//  Copyright © 2016 Meniny Lab. All rights reserved.
//

import Foundation

internal typealias UIActiveableFilterPredicate = ((String) -> Bool)

internal struct UIActiveableBuilder {

    static func elements(type: UIActiveableType, from text: String, range: NSRange, filterPredicate: UIActiveableFilterPredicate?) -> [ElementTuple] {
        switch type {
        case .mention, .hashtag:
            return createElementsIgnoringFirstCharacter(from: text, for: type, range: range, filterPredicate: filterPredicate)
        case .url:
            return createElements(from: text, for: type, range: range, filterPredicate: filterPredicate)
        case .custom:
            return createElements(from: text, for: type, range: range, minLength: 1, filterPredicate: filterPredicate)
        }
    }

    static func URLElements(from text: String, range: NSRange, maximumLenght: Int?) -> ([ElementTuple], String) {
        let type = UIActiveableType.url
        var text = text
        let matches = RegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [ElementTuple] = []

        for match in matches where match.range.length > 2 {
            let word = nsstring.substring(with: match.range)
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

            guard let maxLenght = maximumLenght, word.count > maxLenght else {
                let range = maximumLenght == nil ? match.range : (text as NSString).range(of: word)
                let element = UIActiveableElement.element(with: type, text: word)
                elements.append((range, element, type))
                continue
            }

            let trimmedWord = word.trim(to: maxLenght)
            text = text.replacingOccurrences(of: word, with: trimmedWord)

            let newRange = (text as NSString).range(of: trimmedWord)
            let element = UIActiveableElement.url(original: word, trimmed: trimmedWord)
            elements.append((newRange, element, type))
        }
        return (elements, text)
    }

    private static func createElements(from text: String,
                                            for type: UIActiveableType,
                                                range: NSRange,
                                                minLength: Int = 2,
                                                filterPredicate: UIActiveableFilterPredicate?) -> [ElementTuple] {

        let matches = RegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [ElementTuple] = []

        for match in matches where match.range.length > minLength {
            let word = nsstring.substring(with: match.range)
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if filterPredicate?(word) ?? true {
                let element = UIActiveableElement.element(with: type, text: word)
                elements.append((match.range, element, type))
            }
        }
        return elements
    }

    private static func createElementsIgnoringFirstCharacter(from text: String,
                                                                  for type: UIActiveableType,
                                                                      range: NSRange,
                                                                      filterPredicate: UIActiveableFilterPredicate?) -> [ElementTuple] {
        let matches = RegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [ElementTuple] = []

        for match in matches where match.range.length > 2 {
            let range = NSRange(location: match.range.location + 1, length: match.range.length - 1)
            var word = nsstring.substring(with: range)
            if word.hasPrefix("@") {
                word.remove(at: word.startIndex)
            }
            else if word.hasPrefix("#") {
                word.remove(at: word.startIndex)
            }

            if filterPredicate?(word) ?? true {
                let element = UIActiveableElement.element(with: type, text: word)
                elements.append((match.range, element, type))
            }
        }
        return elements
    }
}
