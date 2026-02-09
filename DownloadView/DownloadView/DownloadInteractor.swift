//
//  DownloadInteractor.swift
//  DownloadView
//
//  Created by next on 04/02/26.
//

import Foundation
class DownloadInteractor: NSObject,
                                DownloadPresenterToInteractorProtocol,
                                URLSessionDelegate,
                                URLSessionDownloadDelegate {

    weak var presenter: DownloadInteractorToPresenterProtocol?

    private var downloadTask: URLSessionDownloadTask?
    private var resumeData: Data?
    private var cancelData: Data?

    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(
            configuration: config,
            delegate: self,
            delegateQueue: .main
        )
    }()

    // MARK: - Start Download (URLRequest)
    func downloadFile() {
        guard let url = URL(string:
                                "https://www.adb.org/sites/default/files/linked-documents/2-India-Country-Context.pdf"
                                //"https://www.mea.gov.in/Uploads/PublicationDocs/184_india-dynamic-democracy.pdf"
                                // "https://www.indiabudget.gov.in/budget2012-2013/es2011-12/echap-14.pdf"
        ) else { return }

        downloadTask = session.downloadTask(with: url)
        downloadTask?.resume()
    }


    // MARK: - Pause Download
    func pauseDownload() {
        downloadTask?.cancel(byProducingResumeData: { data in
            self.resumeData = data
        })
    }

    // MARK: - Resume Download
    func resumeDownload() {
        guard let resumeData = resumeData else { return }
        downloadTask = session.downloadTask(withResumeData: resumeData)
        downloadTask?.resume()
    }
    // MARK: - Cancel Download
    func cancelDownload() {
        downloadTask?.cancel()
        downloadTask = nil
        resumeData =  nil
        presenter?.didUpdateProgress(0.0)
    }

    // MARK: - Progress
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64
    ) {
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        presenter?.didUpdateProgress(progress)
    }

    // MARK: - Finished
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL
    ) {
        print(" Download finished at temp location:", location)
    }
}


