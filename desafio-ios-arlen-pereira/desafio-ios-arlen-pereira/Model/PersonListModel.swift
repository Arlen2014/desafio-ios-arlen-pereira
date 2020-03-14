//
//  PersonListModel.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation

struct PersonListModel: Decodable
{
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: PersonListDataModel?
}

struct PersonListDataModel: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [PersonListResultModel]?
}

struct PersonListResultModel: Decodable
{
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: PersonListThumbnailModel?
    let resourceURI: String?
    let comics: PersonListComicsModel?
    let series: PersonListSeriesModel?
    let stories: PersonListStoriesModel?
    let events: PersonListEventsModel?
    let urls: [PersonListUrlsModel]?
}

struct PersonListThumbnailModel: Decodable
{
    let path: String?
    let `extension`: String?
}

struct PersonListComicsModel: Decodable
{
    let available: Int?
    let collectionURI: String?
    let items: [PersonListComicsItemsModel]?
    let returned: Int?
}

struct PersonListComicsItemsModel: Decodable
{
    let resourceURI: String?
    let name: String?
}

struct PersonListSeriesModel: Decodable
{
    let available: Int?
    let collectionURI: String?
    let items: [PersonListSeriesItemsModel]?
    let returned: Int?
}

struct PersonListSeriesItemsModel: Decodable
{
    let resourceURI: String?
    let name: String?
}

struct PersonListStoriesModel: Decodable
{
    let available: Int?
    let collectionURI: String?
    let items: [PersonListStoriesItemsModel]?
    let returned: Int?
}

struct PersonListStoriesItemsModel: Decodable
{
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct PersonListEventsModel: Decodable
{
    let available: Int?
    let collectionURI: String?
    let items: [PersonListEventsItemsModel]?
    let returned: Int?
}

struct PersonListEventsItemsModel: Decodable
{
    let resourceURI: String?
    let name: String?
}

struct PersonListUrlsModel: Decodable
{
    let type: String?
    let url: String?
}
