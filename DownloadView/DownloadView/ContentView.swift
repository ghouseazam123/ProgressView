//
//  ContentView.swift
//  DownloadView
//
//  Created by next on 04/02/26.
//


import SwiftUI

struct DownloadView: View {

    @StateObject var presenter: DownloadPresenter

    var body: some View {
        VStack(spacing: 40) {

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 12)

                Circle()
                    .trim(from: 0, to: presenter.progress)
                    .stroke(
                        Color.blue,
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: presenter.progress)

                Text("\(Int(presenter.progress * 100))%")
                    .font(.title)
                    .bold()
            }
            .frame(width: 150, height: 150)
            HStack {
                Button("StartDownload") {
                    presenter.startDownload()
                }

                Button("Pause") {
                    presenter.pauseDownload()
                }

                Button("Resume") {
                    presenter.resumeDownload()
                }
                Button("Cancel") {
                    presenter.cancelDownload()
                }
                .disabled(!presenter.iscancelEnabled)
            }.padding()
            
        }
        .padding()
    }
}


//struct DownloadView_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadView()
//    }
//}
