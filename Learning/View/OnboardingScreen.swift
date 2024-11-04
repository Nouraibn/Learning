import SwiftUI

struct OnboardingScreen: View {
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 140)
                    Text("🔥")
                        .font(.system(size: 60))
                }
                .padding(.bottom, 40.0)

                VStack(alignment: .leading) {
                    Text("Hello Learner!")
                        .font(.largeTitle)
                        .bold()

                    Text("This app will help you learn every day")
                        .foregroundColor(.gray.opacity(0.4))

                    Text("I want to learn")
                        .font(.headline)
                        .padding(.top, 20.0)
                        .bold()

                    OnboardingViewModel.UnderlinedTextField(text: Binding(
                        get: { viewModel.text },
                        set: { viewModel.updateText($0) }
                    ), placeholder: "Swift")
                        .padding(.top, -8.0)

                    Text("I want to learn it in a")
                        .font(.headline)
                        .padding(.top, 20.0)
                        .bold()

                    HStack {
                        ForEach([LearningOption.week, .month, .year], id: \.self) { option in
                            Button(action: {
                                viewModel.selectChoice(option)
                            }) {
                                Text(option.rawValue)
                                    .frame(width: 70, height: 40)
                                    .background(viewModel.selectedChoice == option ? Color.color1 : Color.gray.opacity(0.3))
                                    .foregroundColor(viewModel.selectedChoice == option ? Color.black : Color.color1)
                                    .cornerRadius(8)
                            }
                        }
                    }

                    // Centered Start Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: MainScreen(title: viewModel.text, defaultFreezeDays: viewModel.defaultFreezeDays)
                            .navigationBarBackButtonHidden(true),
                            isActive: $viewModel.isNavigating) {
                            Button(action: { viewModel.isNavigating = true }) {
                                HStack {
                                    Text("Start")
                                    Image(systemName: "arrow.right")
                                }
                                .frame(width: 160, height: 50)
                                .background(Color.color1)
                                .foregroundColor(Color.black)
                                .cornerRadius(8)
                                .font(.headline)
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 50.0)
                }
                .padding(.top, 2.0)
            }
            .padding(.bottom, 150.0)
            .padding(.leading, 20.0)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    OnboardingScreen()
        .preferredColorScheme(.dark)
}


