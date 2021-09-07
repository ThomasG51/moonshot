//
//  ContentView.swift
//  Project_8_Moonshot
//
//  Created by Thomas George on 30/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var showingCrew: Bool = false
    
    let astronauts: [Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    var team: [Astronaut] = [Astronaut]()
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                    
                        if (showingCrew) {
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                        } else {
                            ForEach (mission.crew, id: \.name) { crew in
                                Text(crew.name)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle("", isOn: $showingCrew))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
