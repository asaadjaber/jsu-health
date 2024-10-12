struct Clinic: Hashable {
    let clinicName: String
    
    var timeSlots: [TimeSlot]? = []
}
