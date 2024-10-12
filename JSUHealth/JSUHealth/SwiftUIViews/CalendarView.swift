import SwiftUI

struct CalendarView: View {
    @State private var date = Date() {
        didSet {
            updatedDate?()
        }
    }
    
    var updatedDate: (() -> Void)?
    
    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}

#Preview {
    CalendarView()
}
