//
//  CatListView.swift
//  Sesion07
//
//  Created by DAMII on 16/12/24.
//

import SwiftUI

struct CatListView: View {
    @StateObject private var viewModel = CatViewModel()
    @State private var search: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        if search.isEmpty {
                            viewModel.fetchCats()
                        } else {
                            viewModel.searchCats(text: search)
                        }
                    }
                    .autocorrectionDisabled(true)
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Cargando gatos...")
                    } else if let errorMessage = viewModel.messageError {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List(viewModel.cats) { cat in
                            NavigationLink(destination: CatDetailView(cat: cat)) {
                                HStack {
                                    if let imageUrl = cat.image?.url, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { item in
                                            item
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(10)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    } else {
                                        Image(systemName: "xmark")
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(cat.name)
                                        .font(.headline)
                                    Text("Origen: \(cat.origin)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Gatos")
            .onAppear {
                viewModel.fetchCats()
            }
        }
    }
}
