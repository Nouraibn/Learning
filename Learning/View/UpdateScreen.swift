
import SwiftUI

struct UpdateScreen: View {
    @StateObject private var viewModel = UpdateScreenViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack(alignment: .center) {
                        Text("Learning goal")
                            .font(.title3)
                            .bold()
                            .padding(.leading, 95.0)
                        
                        // Update Button to trigger navigation
                        Button(action: {
                            viewModel.isNavigating = true
                        }) {
                            Text("Update")
                                .bold()
                                .foregroundColor(.color1)
                        }
                        .padding(.leading, 40.0)
                    }
                    .padding([.leading, .bottom], 20.0)
                    
                    VStack(alignment: .leading) {
                        Text("I want to learn")
                            .font(.headline)
                            .bold()
                        
                        OnboardingViewModel.UnderlinedTextField(
                            text: $viewModel.text,
                            placeholder: "Swift"
                        )
                        .padding(.top, -5.0)
                        .focused($isTextFieldFocused)
                        
                        Text("I want to learn it in a")
                            .font(.headline)
                            .padding(.top, 20.0)
                            .bold()
                        
                        HStack {
                            ChoiceButton(title: "Week", isSelected: viewModel.selectedChoice == "Week") {
                                viewModel.updateFreezeDays(for: "Week")
                            }
                            
                            ChoiceButton(title: "Month", isSelected: viewModel.selectedChoice == "Month") {
                                viewModel.updateFreezeDays(for: "Month")
                            }
                            
                            ChoiceButton(title: "Year", isSelected: viewModel.selectedChoice == "Year") {
                                viewModel.updateFreezeDays(for: "Year")
                            }
                        }
                    }
                    .padding(.leading)
                }
                .padding(.bottom, 430)
                .onAppear {
                    isTextFieldFocused = true
                }
                
                // NavigationLink to MainScreen
                NavigationLink(
                    destination: MainScreen(title: viewModel.text, defaultFreezeDays: viewModel.defaultFreezeDays)
                        .navigationBarBackButtonHidden(true),
                    isActive: $viewModel.isNavigating
                ) {
                    EmptyView()
                }
            }
            .padding([.bottom, .trailing])
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color.color1)
                                .bold()
                            Text("Back")
                                .foregroundColor(Color.color1)
                                .bold()
                        }
                        .padding(.top, 70.0)
                    }
                }
            }
        }
    }
}

struct ChoiceButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 70, height: 40)
                .background(isSelected ? Color.color1 : Color.gray.opacity(0.3))
                .foregroundColor(isSelected ? Color.black : Color.color1)
                .cornerRadius(8)
        }
    }
}

#Preview {
    UpdateScreen()
}

