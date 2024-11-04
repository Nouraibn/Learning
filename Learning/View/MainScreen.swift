
import SwiftUI

struct MainScreen: View {
    @StateObject private var viewModel: MainViewModel

    init(title: String, defaultFreezeDays: Int) {
        _viewModel = StateObject(wrappedValue: MainViewModel(title: title, defaultFreezeDays: defaultFreezeDays))
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(viewModel.getFormattedDate(Date()))
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.trailing, 240.0)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Learning \(viewModel.title)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                    }
                    Spacer()
                    NavigationLink(destination: UpdateScreen()) {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 60)
                            .overlay(Text("🔥").font(.system(size: 30)))
                    }
                }
            }

            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 390, height: 220)
                    .cornerRadius(9)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                VStack {
                    HStack(spacing: 160) {
                        Text(viewModel.formattedDate(viewModel.date))
                            .font(.system(size: 18, weight: .bold))
                        
                        HStack(spacing: 40) {
                            Button(action: { viewModel.navigateWeek(by: -1) }) {
                                Image(systemName: "chevron.backward").font(.system(size: 20)).bold().foregroundColor(.color1)
                            }
                            Button(action: { viewModel.navigateWeek(by: 1) }) {
                                Image(systemName: "chevron.forward").font(.system(size: 20)).bold().foregroundColor(.color1)
                            }
                        }
                    }
                    
                    // Calendar view
                    LazyVGrid(columns: Array(viewModel.columns.prefix(7))) {
                        ForEach(0..<7, id: \.self) { index in
                            let calendar = Calendar.current
                            let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: viewModel.date))!
                            let day = calendar.date(byAdding: .day, value: index, to: weekStart)!
                            
                            VStack(spacing: 14) {
                                Text(viewModel.daysOfWeek[index])
                                    .font(.system(size: 12))
                                    .bold()
                                    .foregroundColor(day == Calendar.current.startOfDay(for: Date()) ? Color.white : Color.gray.opacity(0.4))
                                
                                Text(day.formatted(.dateTime.day()))
                                    .font(.title2)
                                    .foregroundColor(day == Calendar.current.startOfDay(for: Date()) ? (viewModel.isTodayFrozen || viewModel.isTodayLogged ? Color.white : Color.color1) : Color.white)
                                    .overlay(
                                        ZStack {
                                            if viewModel.getLogStatus(for: day) == .logged {
                                                Circle().fill(Color.color1).frame(width: 50, height: 50)
                                            } else if viewModel.getLogStatus(for: day) == .frozen {
                                                Circle().fill(Color.blue).frame(width: 50, height: 50)
                                            }
                                            Text(day.formatted(.dateTime.day())).font(.title2).foregroundColor(Color.white)
                                        }
                                    )
                            }
                        }
                    }
                    
                    HStack(spacing: 60) {
                        VStack {
                            Text("\(viewModel.logCount)🔥").font(.title).bold()
                            Text("Day streak").foregroundColor(.gray.opacity(0.4))
                        }
                        
                        Rectangle().fill(Color.gray.opacity(0.5)).frame(width: 0.7, height: 70)
                        
                        VStack {
                            Text("\(viewModel.freezeCount)🧊").font(.title).bold()
                            Text("Day Freezed").foregroundColor(.gray.opacity(0.4))
                        }
                    }
                }
            }
            
            VStack {
                Button(action: viewModel.toggleLogToday) {
                    ZStack {
                        Circle().fill(viewModel.isTodayFrozen ? Color.color6 : (viewModel.isTodayLogged ? Color.color4 : Color.color1)).frame(width: 300, height: 300)
                        Text(viewModel.isTodayFrozen ? "Day\n Freezed" : (viewModel.isTodayLogged ? "Learned\n Today" : "Log today\n as Learned")).font(.largeTitle).bold()
                    }
                }
                
                Button(action: viewModel.toggleFreezeToday) {
                    ZStack {
                        Rectangle().fill(viewModel.isTodayFrozen ? Color.color5 : (viewModel.isTodayLogged ? Color.color5 : Color.color2)).frame(width: 160, height: 50).cornerRadius(8)
                        Text("Freeze day").foregroundColor(viewModel.isTodayFrozen ? Color.gray : (viewModel.isTodayLogged ? Color.gray : Color.color3)).bold()
                    }
                }
                
                Text("\(viewModel.freezeCount) out of \(viewModel.defaultFreezeDays) freezes used").foregroundColor(.gray.opacity(0.4))
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: viewModel.loadLogStatus)
    }
}

#Preview {
    MainScreen(title: "Swift", defaultFreezeDays: 2)
}
