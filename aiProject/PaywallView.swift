// страница с оплатой

import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State private var selectedPlan: SubscriptionPlan? = .annual

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    ZStack(alignment: .bottom) {
                        ZStack(alignment: .bottom) {
                            Image("paywall_background")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 260)
                                .clipped()
                                .blur(radius: 5)

                            VStack {
                                Spacer()
                                Rectangle()
                                    .fill(Color.black.opacity(0.4))
                                    .frame(height: 100)
                                    .blur(radius: 20)
                            }
                        }

                        VStack(spacing: 8) {
                            Text("GET")
                                .foregroundColor(.white)
                            Text("Unlimited communication")
                                .foregroundColor(.orange)
                                .bold()
                            Text("with an AI friend!")
                                .foregroundColor(.white)
                        }
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .offset(y: 20)
                    }
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 16) {
                        benefit("Unlimited communication", icon: "bubble.left.and.bubble.right.fill")
                        benefit("Access to all photos", icon: "camera.fill")
                        benefit("Access to all articles", icon: "doc.text.fill")
                        benefit("No Ads", icon: "nosign")
                    }
                    .padding(.horizontal)

                    VStack(spacing: 16) {
                        ForEach(SubscriptionPlan.allCases, id: \.self) { plan in
                            subscriptionOption(plan: plan)
                        }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        if let selected = selectedPlan,
                           let product = subscriptionManager.products.first(where: { $0.id == selected.productID }) {
                            Task {
                                await subscriptionManager.purchase(product)
                            }
                        }
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    HStack {
                        Button("Terms of Use") {}
                        Spacer()
                        Button("Privacy Policy") {}
                    }
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, 5)

                    Spacer().frame(height: 40)
                }
                .padding(.top, -20)
            }

            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }

    // MARK: - Subscription Option

    func subscriptionOption(plan: SubscriptionPlan) -> some View {
        let isSelected = selectedPlan == plan

        return HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(plan.title)
                    .foregroundColor(.white)
                    .font(.subheadline.bold())
                Text(plan.subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(plan.price)
                    .font(.title3.bold())
                    .foregroundColor(.white)
            }

            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 20, height: 20)

                if isSelected {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(isSelected ? 0.1 : 0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.red : Color.clear, lineWidth: 2)
        )
        .cornerRadius(12)
        .onTapGesture {
            selectedPlan = plan
        }
    }

    // MARK: - Benefits

    func benefit(_ text: String, icon: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Subscription Enum

enum SubscriptionPlan: String, CaseIterable {
    case weekly
    case monthly
    case annual

    var title: String {
        switch self {
        case .weekly: return "WEEKLY SUBSCRIPTION"
        case .monthly: return "MONTHLY SUBSCRIPTION"
        case .annual: return "ANNUAL SUBSCRIPTION"
        }
    }

    var subtitle: String {
        switch self {
        case .weekly: return "per week"
        case .monthly: return "$24.99 per month"
        case .annual: return "$99.99 per year"
        }
    }

    var price: String {
        switch self {
        case .weekly: return "$12.19"
        case .monthly: return "$6.19"
        case .annual: return "$1.19"
        }
    }

    var productID: String {
        switch self {
        case .weekly: return "com.yourcompany.yourapp.weekly"
        case .monthly: return "com.yourcompany.yourapp.monthly"
        case .annual: return "com.yourcompany.yourapp.annual"
        }
    }
}
