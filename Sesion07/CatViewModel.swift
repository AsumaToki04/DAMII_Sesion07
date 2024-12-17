//
//  CatViewModel.swift
//  Sesion07
//
//  Created by DAMII on 16/12/24.
//

import Foundation

@MainActor
class CatViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var isLoading = false
    @Published var messageError: String?
    
    func fetchCats() {
        Task {
            do {
                isLoading = true
                messageError = nil
                cats = try await CatService.shared.fetchCats()
            } catch {
                messageError = "Error: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    func searchCats(text: String) {
        Task {
            do {
                isLoading = true
                messageError = nil
                cats = try await CatService.shared.searchCats(text: text)
            } catch {
                messageError = "Error: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
