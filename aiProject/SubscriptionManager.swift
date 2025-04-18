// проверка подписки

import Foundation
import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {
    static let shared = SubscriptionManager()

    @Published var isSubscribed: Bool = false
    @Published var products: [Product] = []

    private init() {}

    func loadProducts() async {
        do {
            let ids: Set<String> = [
                "com.yourcompany.yourapp.weekly",
                "com.yourcompany.yourapp.monthly",
                "com.yourcompany.yourapp.annual"
            ]

            products = try await Product.products(for: ids)
        } catch {
            print("Failed to load products:", error)
        }
    }

    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(.verified(let transaction)):
                print("Success: \(transaction.productID)")
                await transaction.finish()
                isSubscribed = true

            case .success(.unverified(_, _)):
                print("Purchase unverified")
            case .userCancelled:
                print("User cancelled")
            case .pending:
                print("Pending...")
            @unknown default:
                break
            }
        } catch {
            print("Purchase failed:", error)
        }
    }

    func checkSubscriptionStatus() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.productType == .autoRenewable {
                isSubscribed = true
                return
            }
        }

        isSubscribed = false
    }
}
