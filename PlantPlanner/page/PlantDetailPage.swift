import SwiftUI

struct PlantDetailPage: View {
    @Binding var plants: [UserPlantData]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var refresh = false
    
    var plant: UserPlantData
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.cyan.opacity(0.25), Color.green.opacity(0.25)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .all)

            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 10) {
                        Image(plant.plant.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 3))
                        
                        Text("\(plant.name)'s Pot")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Text(plant.plant.name)
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    VStack(spacing: 18) {
                        HStack {
                            VStack {
                                Image(systemName: "sun.max.fill")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                                Text("Status")
                                    .font(.subheadline)
                                Text("Reasonably healthy")
                                    .font(.callout)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "leaf.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.green)
                                Text("Planted Flowers")
                                    .font(.subheadline)
                                Text("flowers")
                                    .font(.callout)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.9))
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                        )
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                detailRow(icon: "sun.max", title: "Lighting", value: "Sunny")
                                Spacer()
                                detailRow(icon: "calendar", title: "Planting Date", value: formattedDate(plant.plantingDate))
                            }
                            Divider()
                            HStack {
                                detailRow(icon: "ruler.fill", title: "Height", value: "30 cm - 2 m")
                                Spacer()
                                detailRow(icon: "arrow.left.and.right", title: "Seed Distance", value: "15 cm")
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorScheme == .dark ? .black.opacity(0.85) : .white.opacity(0.85))
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                        )
                        
                        HStack {
                            detailRow(icon: "cube.fill", title: "Size", value: plant.size)
                            Spacer()
                            if let vaseType = plant.vaseType {
                                detailRow(icon: "square.and.pencil", title: "Vase Type", value: vaseType)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorScheme == .dark ? .black.opacity(0.85) : .white.opacity(0.85))
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                        )
                    }
                    
                    infoCard(title: "Did You Know?", content: plant.plant.didYouKnow)
                    
                    infoCard(title: "Important Info", content: plant.plant.importantInfo)
                }
                .padding()
            }
        }
        .navigationBarTitle(plant.plant.scientificName, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    deletePlant()
                    update()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private func deletePlant() {
        PlantCache.shared.deleteUserPlant(plant: plant)
        plants =  PlantCache.shared.loadUserPlantsFromJSON()
        dismiss()
    }
    
    private func update() { refresh.toggle() }
    
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.callout)
                    .foregroundColor(.black)
            }
        }
    }
    
    private func infoCard(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Text(content)
                .font(.callout)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
        )
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
