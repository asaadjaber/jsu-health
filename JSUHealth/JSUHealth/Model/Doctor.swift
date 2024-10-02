struct Doctor: Hashable {
    let name: String
    let practiceArea: PracticeArea
}

enum PracticeArea: String {
    case familyMedicine = "Family Medicine"
    case physicalTherapy = "Physical Therapy"
    case orthopedics = "Orthopedics"
}
