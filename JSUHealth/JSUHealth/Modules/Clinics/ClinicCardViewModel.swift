//
//  ClinicCardViewModel.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 19/09/2024.
//

import Foundation

class ClinicCardViewModel {
    
    var clinics: [Item] = [
        Item.clinicCard(ClinicCard(name: "Medivia Sağlık Grubu", imageName: "health center", location: "Istanbul")),
        Item.clinicCard(ClinicCard(name: "Lokman Hekim University Ankara Hospital", imageName: "dental clinic", location: "Ankara")),
        Item.clinicCard(ClinicCard(name: "Acıbadem Bursa Hospital", imageName: "hospital", location: "Bursa"))
    ]
    
    let photoProvider = PhotoProvider()

    func makeImageQuery(query: String) async -> (Data?, URLResponse?) {
        await photoProvider.makeImageQuery(query: query)
    }
}
