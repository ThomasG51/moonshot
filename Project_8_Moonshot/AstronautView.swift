//
//  AstronautView.swift
//  Project_8_Moonshot
//
//  Created by Thomas George on 01/09/2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    var flewMissions: [Mission] = [Mission]()
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var missionsFound: [Mission] = [Mission]()
        for mission in self.missions {
            if mission.crew.first(where: { $0.name == self.astronaut.id }) != nil {
                missionsFound.append(mission)
            }
        }
        
        self.flewMissions = missionsFound
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    
                    HStack {
                        Text("Missions:")
                            .font(.headline)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                    
                    ForEach(self.flewMissions, id: \.id) { mission in
                        
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .scaledToFit()
                            
                            VStack (alignment: .leading) {
                                Text("\(mission.displayName)")
                                Text("\(mission.formattedLaunchDate)")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationTitle(Text("\(self.astronaut.name)"))
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronaut: [Astronaut] = Bundle.main.decode(file: "astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronaut[0])
    }
}
