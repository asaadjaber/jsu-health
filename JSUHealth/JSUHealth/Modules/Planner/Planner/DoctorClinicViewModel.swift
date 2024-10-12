import Foundation

struct DoctorClinicViewModel {
    let items: [PlannerItem] = [
        PlannerItem.doctor(Doctor(name: "Janet J. Arribas, DO",
                                  practiceArea: .familyMedicine,
                                  timeSlots: [
                                    TimeSlot(startDate: DateComponents(year: 2024, month: 10, day: 12, hour: 11)),
                                    TimeSlot(startDate: DateComponents(year: 2024, month: 10, day: 12, hour: 13)),
                                    TimeSlot(startDate: DateComponents(year: 2024, month: 10, day: 12, hour: 13, minute: 30)),
                                    TimeSlot(startDate: DateComponents(year: 2024, month: 10, day: 12, hour: 14, minute: 30)),
                                    TimeSlot(startDate: DateComponents(year: 2024, month: 10, day: 12, hour: 15, minute: 45))
                                  ])),
        PlannerItem.doctor(Doctor(name: "Dr. Loretta Zelenko", practiceArea: .physicalTherapy)),
        PlannerItem.doctor(Doctor(name: "Dr. Shelby Prestwood", practiceArea: .orthopedics)),
        
        PlannerItem.clinic(Clinic(clinicName: "Northwell Health")),
        PlannerItem.clinic(Clinic(clinicName: "Digestive Disease Care PC"))
    ]
}
