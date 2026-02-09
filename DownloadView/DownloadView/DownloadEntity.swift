//
//  DownloadEntity.swift
//  DownloadView
//
//  Created by next on 04/02/26.
//



import Foundation

struct DownloadEntity {
    let progress: Double
}


// View → Presenter
protocol DownloadViewToPresenterProtocol {
    func startDownload()
    func pauseDownload()
    func resumeDownload()
    func cancelDownload()
}

// Presenter → Interactor
protocol DownloadPresenterToInteractorProtocol {
    func downloadFile()
    func pauseDownload()
    func resumeDownload()
    func cancelDownload()
}

// Interactor → Presenter
protocol DownloadInteractorToPresenterProtocol: AnyObject {
    func didUpdateProgress(_ progress: Double)
}

// Router
protocol DownloadRouterProtocol { }

