//
//  ProcedureCardViewModel.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import Foundation

class ProcedureCardViewModel {
    
    var procedures: [Item] = [
        Item.procedureCard(ProcedureCard(id: UUID().uuidString, imageName: "plastic surgery", price: 15000, procedures: ["liposuction", "rhinoplasty", "breast implants"])),
        Item.procedureCard(ProcedureCard(id: UUID().uuidString, imageName: "hair transplant", price: 10000, procedures: ["FUE hair transplant", "beard transplant", "DHI hair transplant"])),
        Item.procedureCard(ProcedureCard(id: UUID().uuidString, imageName: "dentistry", price: 7000, procedures: ["dental implants", "veneers", "crowns"]))
    ]
    
    let photoProvider = PhotoProvider()
    
    func makeImageQuery(query: String) async -> (Data?, URLResponse?) {
        await photoProvider.makeImageQuery(query: query)
    }
}
