import SwiftUI
import Core
import Kingfisher

public struct MovieRowView: View {
    public let movie: Movie
    public let isFavorite: Bool
    public var showFavoriteButton: Bool
    public var onToggleFavorite: () -> Void
    
    // Helper untuk mendapatkan bundel modul Shared
    private var currentBundle: Bundle {
        class BundleFinder {}
        return Bundle(for: BundleFinder.self)
    }

    public init(movie: Movie, isFavorite: Bool, showFavoriteButton: Bool = true, onToggleFavorite: @escaping () -> Void) {
        self.movie = movie
        self.isFavorite = isFavorite
        self.showFavoriteButton = showFavoriteButton
        self.onToggleFavorite = onToggleFavorite
    }

    public var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: Constants.imageBaseURL + (movie.posterPath ?? "")))
                .placeholder {
                    // PERBAIKAN: Beritahu Image untuk mencari di 'currentBundle'
                    Image("placeholder_poster", bundle: currentBundle)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 120)
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.primaryText)
                    .lineLimit(2)
                
                if let rating = movie.rating, rating > 0 {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.theme.accent)
                        Text(String(format: "%.1f", rating))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }

                Text(movie.overview ?? "No overview available.")
                    .font(.caption)
                    .lineLimit(3)
                    .foregroundColor(Color.theme.secondaryText)
            }

            Spacer()

            if showFavoriteButton {
                Button(action: onToggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(12)
        .background(Color.theme.surface)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
    }
}
