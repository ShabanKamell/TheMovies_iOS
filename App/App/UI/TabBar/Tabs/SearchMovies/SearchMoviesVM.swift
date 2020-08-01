//
// Created by Shaban Kamel on 04/02/2020.
// Copyright (c) 2020 sha. All rights reserved.
//

import RxRequester
import Data
import Presentation
import RxSwift

class SearchMoviesVM: ViewModelProtocol {
    var requester: AppRequester!
    var dm: DataManager

    public init(rxRequester: AppRequester, dm: DataManager) {
        self.requester = rxRequester
        self.dm = dm
    }

    func isValidSearch(query: String?) -> Bool {
        query?.isEmpty != true
    }

    func searchMovies(request: MoviesRequest, showLoading: Bool = true) -> Single<MoviesResponse> {
        let options = RequestOptions.Builder()
                .showLoading(showLoading)
                .build()
        return requester.request(options: options, singleRequest: {
            self.dm.moviesRepo.searchMovies(request: request)
        })
    }
}
