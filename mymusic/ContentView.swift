//
//  ContentView.swift
//  mymusic
//
//  Created by Naveen Akkula on 10/1/22.
//

import SwiftUI

struct Song: Identifiable{
    var id: String { title }
    let title: String
    let artist: String
    let coverString: String
}

struct ContentView: View {
    let songs = [
    Song(title: "Senorita", artist: "Shawn Mendes feat Camilla Cabello", coverString: "camillacover"),
    
    Song(title: "Don't Go Yet", artist: "Camilla Cabello", coverString: "camillacover"),
    
    Song(title: "Never Be the Same", artist: "Camilla Cabello", coverString: "camillacover"),
    
    Song(title: "Bam Bam", artist: "Camilla Cabello", coverString: "camillacover"),
    
    Song(title: "Worth It", artist: "Camilla Cabello", coverString: "camillacover")]
    
    
@State private var isPlaying = false
    @State private var isLiked = false
    
    let bgColor = Color(hue: 0.0, saturation: 0.0, brightness: 0.074)
    
    func getOffsetY(reader: GeometryProxy) -> CGFloat{
        let offsetY: CGFloat = -reader.frame(in: .named("scrollView")).minY
    if offsetY < 0{
        return offsetY / 10.0
    }
    return offsetY
}
    var body: some View {
        ScrollView(showsIndicators:false){
            //album cover
            GeometryReader { reader in
                
                //making the album cover more dynamic looking
                let offsetY = getOffsetY(reader: reader)
                let height: CGFloat = (reader.size.height - offsetY) +
                offsetY / 3
                let minHeight: CGFloat = 120
                let opacity = (height - minHeight) / (reader.size.height - minHeight)
                
                ZStack{
                    LinearGradient(gradient: Gradient(colors:[Color.red, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        .scaleEffect(7)
                    
                    Image("camillacover")
                        .resizable()
                        .frame(width: height, height: height  )
                        .offset(y: offsetY)
                        .opacity(Double(opacity))
                        .shadow(color: Color.red.opacity(0.5), radius: 30)
                }
                .frame(width:reader.size.width)
            }
            .frame(height:250)
            Spacer().frame(height: 20)

            albumsDetailsView
                .padding(.horizontal)
            
            songsListView
                .padding(.horizontal)
            }
            .coordinateSpace(name: "scrollView")
            .background(bgColor.ignoresSafeArea())
            
        }
    var songsListView: some View{
        ForEach(songs) {song in
            HStack{
                Image(song.coverString)
                    .resizable()
                    .frame(maxHeight:.infinity)
                    .aspectRatio(1, contentMode: .fit)
                VStack(alignment: .leading, spacing: 5){
                    Text(song.title)
                        .font(.title3)
                        .bold()
                    
                    Text(song.artist)
                        .font(.subheadline)
                        .bold()
                        .opacity(0.8)
                }
                Spacer()
                
                Image(systemName: "ellipsis" )
                    .font(.system(size: 20))
                    .frame(maxHeight: .infinity)
                    .opacity(0.8)
                
            }
            .frame(height: 80)
            .foregroundColor(.white)
            
        }
    }
    var albumsDetailsView: some View{
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text("Camilla Cabello")
                    .font(.title)
                    .bold()
                
                HStack{
                    Image("Havana_(featuring_Young_Thug)_(Official_Single_Cover)_by_Camila_Cabello")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text("Following")
                        .font(.title3)
                        .bold()
                        .font(.subheadline)

                }
                Text("Album Songs")
                    .font(.title2)
                    .bold()
                    .opacity(0.6)
                Text("Liked Songs")
                    .font(.title3)
                    .bold()
                    .opacity(0.6)
                HStack(spacing:30){
                    Button(action: {
                        isLiked.toggle()
                    }){
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.system(size:30))
                            .padding(.top,10)
                    }
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .frame(maxHeight: .infinity)
                        .offset(y:5)
                }
            }
            .foregroundColor(.white)
            
            Spacer().frame(height: 25)
            // when you press the button it will go from play to pause
            Button(action: {
                isPlaying.toggle()
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                    Image(systemName: isPlaying ? "pause.fill": "play.fill")
                        .font(.system(size:35))
                        .foregroundColor(.white)
                }
                .frame(width: 70, height: 70)
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    
}
