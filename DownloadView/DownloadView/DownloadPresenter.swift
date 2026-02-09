//
//  DownloadPresenter.swift
//  DownloadView
//
//  Created by next on 04/02/26.
//


import Foundation
import SwiftUI

class DownloadPresenter: ObservableObject {

    @Published var progress: Double = 0.0
    @Published var iscancelEnabled: Bool = false

    var interactor: DownloadPresenterToInteractorProtocol?
    var router: DownloadRouterProtocol?
}

// View → Presenter
extension DownloadPresenter: DownloadViewToPresenterProtocol {
    func startDownload() {
        interactor?.downloadFile()
    }

    func pauseDownload() {
        interactor?.pauseDownload()
    }

    func resumeDownload() {
        interactor?.resumeDownload()
    }
    func cancelDownload() {
        interactor?.cancelDownload()
    }
}

// Interactor → Presenter
extension DownloadPresenter: DownloadInteractorToPresenterProtocol {
    func didUpdateProgress(_ progress: Double) {
        self.progress = progress
        if progress > 0.0 && progress < 1.0 {
            iscancelEnabled = true
        } else {
            iscancelEnabled = false
        }
    }
}


