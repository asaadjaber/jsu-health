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
    
//    ClinicCard(name: "Acibadem Istanbul", imageName: "medical clinic", location: "Istanbul"),
//    ClinicCard(name: "Turkiye Hospital", imageName: "dentistry", location: "Istanbul"),
//    ClinicCard(name: "Civas Clinic", imageName: "surgery", location: "Ankara"),
//    ClinicCard(name: "Adaport Dental Clinic", imageName: "dental clinic", location: "Izmir"),
//    ClinicCard(name: "Memorial Hospital", imageName: "hospital", location: "Ankara"),
//    ClinicCard(name: "Lokman Hekim University Ankara Hospital", imageName: "hospital", location: "Ankara"),
//    ClinicCard(name: "Antalya Medical Park Clinic", imageName: "medical center", location: "Antalya"),
//    ClinicCard(name: "Izmir Can Hospital", imageName: "hospital", location: "Izmir"),
    
    let photoProvider = PhotoProvider()

    func makeImageQuery(query: String) async -> (Data?, URLResponse?) {
        await photoProvider.makeImageQuery(query: query)
    }
}
