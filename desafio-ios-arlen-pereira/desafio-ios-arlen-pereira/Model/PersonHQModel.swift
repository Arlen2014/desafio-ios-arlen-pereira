//
//  PersonHQModel.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation

struct PersonHQModel: Decodable
{
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: PersonHQDataModel?
}

struct PersonHQDataModel: Decodable
{
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [PersonHQResultModel]?
}

struct PersonHQResultModel: Decodable
{
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [PersonHQTextObjectModel]?
    let resourceURI: String?
    let urls: [PersonHQUrlModel]?
    let series: PersonHQSerieModel?
    let variants: [PersonHQVariantModel]?
    let collections: [PersonHQCollectionModel]?
    let collectedIssues: [PersonHQCollectedIssueModel]?
    let dates: [PersonHQDateModel]?
    let prices: [PersonHQPriceModel]?
    let thumbnail: PersonHQThumbnailModel?
    let images: [PersonHQImageModel]?
    let creators: PersonHQCreatorModel?
    let characters: PersonHQCharacterModel?
    let stories: PersonHQStoryModel?
    let events: PersonHQEventModel?
}

struct PersonHQTextObjectModel: Decodable {
    let type: String?
    let languege: String?
    let text: String?
}

struct PersonHQUrlModel: Decodable {
    let type: String?
    let url: String?
}

struct PersonHQSerieModel: Decodable {
    let resourceURI: String?
    let name: String?
}

struct PersonHQVariantModel: Decodable {
    let resourceURI: String?
    let name: String?
}

struct PersonHQCollectionModel: Decodable {
    let resourceURI: String?
    let name: String?
}

struct PersonHQCollectedIssueModel: Decodable {
    let resourceURI: String?
    let name: String?
}

struct PersonHQDateModel: Decodable {
    let type: String?
    let date: String?
}

struct PersonHQPriceModel: Decodable {
    let type: String?
    let price: Double?
}

struct PersonHQThumbnailModel: Decodable {
    let path: String?
    let `extension`: String?
}

struct PersonHQImageModel: Decodable {
    let path: String?
    let `extension`: String?
}

struct PersonHQCreatorModel: Decodable {
    let avaliable: Int?
    let collectionURI: String?
    let items: [PersonCreatorItemModel]?
    let returned: Int?
}

struct PersonCreatorItemModel: Decodable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

struct PersonHQCharacterModel: Decodable {
    let avaliable: Int?
    let collectionURI: String?
    let items: [PersonCharacterItemModel]?
    let returned: Int?
}

struct PersonCharacterItemModel: Decodable {
    let resourceURI: String?
    let name: String?
}

struct PersonHQStoryModel: Decodable {
    let avaliable: Int?
    let collectionURI: String?
    let items: [PersonStoryItemModel]?
    let returned: Int?
}

struct PersonStoryItemModel: Decodable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct PersonHQEventModel: Decodable {
    let avaliable: Int?
    let collectionURI: String?
    let items: [PersonEventItemModel]?
    let returned: Int?
}

struct PersonEventItemModel: Decodable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

