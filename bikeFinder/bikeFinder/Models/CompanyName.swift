//
//  CompanyName.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

enum CompanyName: Codable {
    case string(String)
    case stringArray([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let name = try? container.decode(String.self) {
            self = .string(name)
            return
        }
        if let names = try? container.decode([String].self) {
            self = .stringArray(names)
            return
        }
        throw DecodingError.typeMismatch(CompanyName.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CompanyName"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let name):
            try container.encode(name)
        case .stringArray(let names):
            try container.encode(names)
        }
    }
}
