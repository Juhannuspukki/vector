//
//  ContentView.swift
//  vector
//
//  Created by Jere Laine on 24.1.2022.
//

import SwiftUI


struct ContentView: View {
    @State private var collections: [Collection] = iconCollections
    @State private var show = false
    @State private var activeIcon: Icon = Icon(id: "ambulance-light-3478132", name: "test", tags: [])
    @State private var activeCollection: String = ""
    @State private var searchText = ""
    
    
    var searchResults: [Collection] {
        if searchText.isEmpty {
            return iconCollections
        } else {
            
            var newArray: [Collection] = []
            
            for collection in collections {
                let filteredIcons = collection.icons.filter { ($0.name.contains(searchText) || $0.tags.contains { tag in return tag.contains(searchText)
                }) }
                
                newArray.append(Collection(name: collection.name, id: collection.id, icons: filteredIcons))
                
                
            }
            
            return newArray
            }
            
        }
    
    
    var body: some View {
        if !show {
            RootView(show: $show, activeIcon: $activeIcon, activeCollection: $activeCollection, searchText: $searchText, collections: searchResults)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        if show {
            NextView(show: $show, activeIcon: $activeIcon, activeCollection: $activeCollection, searchText: $searchText)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
}


struct RootView: View {
    @Binding var show: Bool
    @Binding var activeIcon: Icon
    @Binding var activeCollection: String
    @Binding var searchText: String
    var collections: [Collection]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 5)) {
                ForEach(collections) { collection in
                    ForEach(collection.icons) { icon in
                        let imageName = icon.id
                        Button(action: { self.show = true
                            self.activeIcon = icon
                            self.activeCollection = collection.name
                        }) {
                        label: do {
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                Text(icon.name).font(.subheadline)
                            }
                            
                        }
                        }.buttonStyle(PlainButtonStyle()).padding(20)
                        
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Vector")
    }
}

struct NextView: View {
    @Binding var show: Bool
    @Binding var activeIcon: Icon
    @Binding var activeCollection: String
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            
            let imageName = activeIcon.id
            
            Button(action: { self.show = false }) {
            label: do {
                VStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(activeIcon.name).font(.headline)
                    Text(activeIcon.id).font(.headline)
                    Text(activeCollection).font(.headline)
                    Spacer()
                    /* HStack {
                        ForEach(activeIcon.tags) { tag in
                            Text(tag)
                        }
                    }*/
                }.padding(40)
                
            }
            }.buttonStyle(PlainButtonStyle()).padding(20)
        }.searchable(text: $searchText)
        .navigationTitle(activeIcon.name)}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500.0)
    }
}
