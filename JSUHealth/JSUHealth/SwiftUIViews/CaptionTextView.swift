import SwiftUI

struct CaptionTextView: View {
    
    var title: String
    var cellSize: CGSize
    
    var body: some View {
        Text(title)
            .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
            .font(.system(size: 12.0))
            .fontWeight(.bold)
            .background(.gray)
            .cornerRadius(8.0)
            .foregroundStyle(.white)
            .frame(maxWidth: cellSize.width - 20)
    }
}

#Preview {
    CaptionTextView(title: "From $1000", cellSize: CGSize(width: 300, height: 300))
}
