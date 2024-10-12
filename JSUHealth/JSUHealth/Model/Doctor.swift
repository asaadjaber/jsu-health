struct Doctor: Hashable {
    let name: String
    let practiceArea: PracticeArea
    
    var timeSlots: [TimeSlot]? = []
}

enum PracticeArea: String {
    case familyMedicine = "Family Medicine"
    case physicalTherapy = "Physical Therapy"
    case orthopedics = "Orthopedics"
}
