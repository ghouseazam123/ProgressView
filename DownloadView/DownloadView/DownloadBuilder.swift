//
//  DownloadBuilder.swift
//  DownloadView
//
//  Created by next on 04/02/26.
//

import SwiftUI


class DownloadBuilder {

    static func build() -> some View {

        let presenter = DownloadPresenter()
        let interactor = DownloadInteractor()
        let router = DownloadRouter()

        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return DownloadView(presenter: presenter)
    }
}


