
import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedChoice: LearningOption? = nil
    @Published var isNavigating: Bool = false
    
    // Capitalize the first letter of the entered text
    func updateText(_ newValue: String) {
        text = newValue.isEmpty ? "" : newValue.prefix(1).uppercased() + newValue.dropFirst().lowercased()
    }
    
    // Get the freeze days based on the selected choice
    var defaultFreezeDays: Int {
        selectedChoice?.defaultFreezeDays ?? 0
    }
    
    func selectChoice(_ choice: LearningOption) {
        selectedChoice = choice
    }
    struct UnderlinedTextField: View {
        @Binding var text: String
        var placeholder: String
        var underlineColor: Color = .gray
        
        var body: some View {
            VStack(alignment: .leading) {
                TextField(placeholder, text: $text)
                    .padding(.bottom, 5)
                    .background(Color.clear)
                    .accentColor(.blue)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(underlineColor),
                        alignment: .bottom
                    )
            }
            .padding(.horizontal,6)
        }
    }
}
