//
//  CatDetailView.swift
//  Sesion07
//
//  Created by DAMII on 16/12/24.
//

import SwiftUI

struct CatDetailView: View {
    var cat: Cat
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let imageUrl = cat.image?.url, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { item in
                        item
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Text("Imagen no encontrada")
                        .italic()
                }
                Text("Nombre: \(cat.name)")
                    .font(.headline)
                Text("Origen: \(cat.origin)")
                    .font(.subheadline)
                Text("Temperamento: \(cat.temperament)")
                    .font(.subheadline)
                Text("Descripción:")
                    .font(.headline)
                Text(cat.description)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("\(cat.name)")
    }
}
