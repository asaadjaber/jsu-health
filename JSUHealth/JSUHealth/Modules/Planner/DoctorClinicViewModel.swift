struct DoctorClinicViewModel {
    let items: [PlannerItem] = [
        PlannerItem.doctor(Doctor(name: "Janet J. Arribas, DO", practiceArea: .familyMedicine)),
        PlannerItem.doctor(Doctor(name: "Dr. Loretta Zelenko", practiceArea: .physicalTherapy)),
        PlannerItem.doctor(Doctor(name: "Dr. Shelby Prestwood", practiceArea: .orthopedics)),
        
        PlannerItem.clinic(Clinic(clinicName: "Northwell Health")),
        PlannerItem.clinic(Clinic(clinicName: "Digestive Disease Care PC"))
    ]
}
