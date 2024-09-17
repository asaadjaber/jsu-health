//
//  ProcedureCard.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import Foundation

struct ProcedureCard: Codable, Hashable {
    let id: String
    let imageName: String
    let price: Int
    let procedures: [String]
}
