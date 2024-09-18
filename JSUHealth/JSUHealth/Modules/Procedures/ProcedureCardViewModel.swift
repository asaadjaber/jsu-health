//
//  ProcedureCardViewModel.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import Foundation
import SwiftyJSON

class ProcedureCardViewModel {
    
    var procedures: [ProcedureCard] = [
        ProcedureCard(id: UUID().uuidString, imageName: "plastic surgery", price: 15000, procedures: ["liposuction", "rhinoplasty", "breast implants"]),
        ProcedureCard(id: UUID().uuidString, imageName: "hair transplant", price: 10000, procedures: ["FUE hair transplant", "beard transplant", "DHI hair transplant"]),
        ProcedureCard(id: UUID().uuidString, imageName: "dentistry", price: 7000, procedures: ["dental implants", "veneers", "crowns"]),
        ProcedureCard(id: UUID().uuidString, imageName: "bariatric surgery", price: 5000, procedures: ["gastric sleeve", "gastric bypass surgery", "gastric balloon"]),
        ProcedureCard(id: UUID().uuidString, imageName: "eye care", price: 4000, procedures: ["cataract surgery", "lasik eye surgery", "corneal transplant"]),
        ProcedureCard(id: UUID().uuidString, imageName: "general surgery", price: 3000, procedures: ["mastectomy", "inguinal hernia repair", "liver transplant"]),
        ProcedureCard(id: UUID().uuidString, imageName: "ear, nose and throat", price: 2000, procedures: ["tonsil and adenoid removal", "septal perforation", "septoplasty"]),
        ProcedureCard(id: UUID().uuidString, imageName: "orthopedics", price: 1000, procedures: ["limb lengthening surgery", "carpal tunnel surgery", "hip replacement"])
    ]
    
    let photoProvider = PhotoProvider()
    
    func makeImageQuery(query: String) async -> (Data?, URLResponse?) {
        let (data, response) = await photoProvider.request(from: photoProvider.makeURLRequest(query: query))
        guard let data = data else { return (nil, response) }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Body.self, from: data).results
            let photoURL = result[0].user.profileImage.large
            print("photoURL,", photoURL)
            let (data, response) = await photoProvider.downloadImage(url: photoURL)
            return (data, response)
        } catch {
            print("error decoding data")
        }
        
       return (nil, nil)
    }
}
