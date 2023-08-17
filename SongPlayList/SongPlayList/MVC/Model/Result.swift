//
//	Result.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

enum CurrentPlayerStatus : String {
    case DownloadPending = "DownloadPending"
    case Played = "Played"
    case Paused = "Paused"
}

struct Result {

    var done : Bool = true
	var artistId : Int!
	var artistName : String!
	var artistViewUrl : String!
	var artworkUrl100 : String!
	var artworkUrl30 : String!
	var artworkUrl60 : String!
	var collectionArtistId : Int!
	var collectionArtistName : String!
	var collectionArtistViewUrl : String!
	var collectionCensoredName : String!
	var collectionExplicitness : String!
	var collectionHdPrice : Float!
	var collectionId : Int!
	var collectionName : String!
	var collectionPrice : Float!
	var collectionViewUrl : String!
	var contentAdvisoryRating : String!
	var country : String!
	var currency : String!
	var discCount : Int!
	var discNumber : Int!
	var hasITunesExtras : Bool!
	var isStreamable : Bool!
	var kind : String!
	var longDescription : String!
	var previewUrl : String!
	var primaryGenreName : String!
	var releaseDate : String!
	var shortDescription : String!
	var trackCensoredName : String!
	var trackCount : Int!
	var trackExplicitness : String!
	var trackHdPrice : Float!
	var trackHdRentalPrice : Float!
	var trackId : Int!
	var trackName : String!
	var trackNumber : Int!
	var trackPrice : Float!
	var trackRentalPrice : Float!
	var trackTimeMillis : Int!
	var trackViewUrl : String!
	var wrapperType : String!
    var isDwnldPause : Bool = false
    var currentPlayerStatus : CurrentPlayerStatus  = .DownloadPending
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		artistId = dictionary["artistId"] as? Int
		artistName = dictionary["artistName"] as? String
		artistViewUrl = dictionary["artistViewUrl"] as? String
		artworkUrl100 = dictionary["artworkUrl100"] as? String
		artworkUrl30 = dictionary["artworkUrl30"] as? String
		artworkUrl60 = dictionary["artworkUrl60"] as? String
		collectionArtistId = dictionary["collectionArtistId"] as? Int
		collectionArtistName = dictionary["collectionArtistName"] as? String
		collectionArtistViewUrl = dictionary["collectionArtistViewUrl"] as? String
		collectionCensoredName = dictionary["collectionCensoredName"] as? String
		collectionExplicitness = dictionary["collectionExplicitness"] as? String
		collectionHdPrice = dictionary["collectionHdPrice"] as? Float
		collectionId = dictionary["collectionId"] as? Int
		collectionName = dictionary["collectionName"] as? String
		collectionPrice = dictionary["collectionPrice"] as? Float
		collectionViewUrl = dictionary["collectionViewUrl"] as? String
		contentAdvisoryRating = dictionary["contentAdvisoryRating"] as? String
		country = dictionary["country"] as? String
		currency = dictionary["currency"] as? String
		discCount = dictionary["discCount"] as? Int
		discNumber = dictionary["discNumber"] as? Int
		hasITunesExtras = dictionary["hasITunesExtras"] as? Bool
		isStreamable = dictionary["isStreamable"] as? Bool
		kind = dictionary["kind"] as? String
		longDescription = dictionary["longDescription"] as? String
		previewUrl = dictionary["previewUrl"] as? String
		primaryGenreName = dictionary["primaryGenreName"] as? String
		releaseDate = dictionary["releaseDate"] as? String
		shortDescription = dictionary["shortDescription"] as? String
		trackCensoredName = dictionary["trackCensoredName"] as? String
		trackCount = dictionary["trackCount"] as? Int
		trackExplicitness = dictionary["trackExplicitness"] as? String
		trackHdPrice = dictionary["trackHdPrice"] as? Float
		trackHdRentalPrice = dictionary["trackHdRentalPrice"] as? Float
		trackId = dictionary["trackId"] as? Int
		trackName = dictionary["trackName"] as? String
		trackNumber = dictionary["trackNumber"] as? Int
		trackPrice = dictionary["trackPrice"] as? Float
		trackRentalPrice = dictionary["trackRentalPrice"] as? Float
		trackTimeMillis = dictionary["trackTimeMillis"] as? Int
		trackViewUrl = dictionary["trackViewUrl"] as? String
		wrapperType = dictionary["wrapperType"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if artistId != nil{
			dictionary["artistId"] = artistId
		}
		if artistName != nil{
			dictionary["artistName"] = artistName
		}
		if artistViewUrl != nil{
			dictionary["artistViewUrl"] = artistViewUrl
		}
		if artworkUrl100 != nil{
			dictionary["artworkUrl100"] = artworkUrl100
		}
		if artworkUrl30 != nil{
			dictionary["artworkUrl30"] = artworkUrl30
		}
		if artworkUrl60 != nil{
			dictionary["artworkUrl60"] = artworkUrl60
		}
		if collectionArtistId != nil{
			dictionary["collectionArtistId"] = collectionArtistId
		}
		if collectionArtistName != nil{
			dictionary["collectionArtistName"] = collectionArtistName
		}
		if collectionArtistViewUrl != nil{
			dictionary["collectionArtistViewUrl"] = collectionArtistViewUrl
		}
		if collectionCensoredName != nil{
			dictionary["collectionCensoredName"] = collectionCensoredName
		}
		if collectionExplicitness != nil{
			dictionary["collectionExplicitness"] = collectionExplicitness
		}
		if collectionHdPrice != nil{
			dictionary["collectionHdPrice"] = collectionHdPrice
		}
		if collectionId != nil{
			dictionary["collectionId"] = collectionId
		}
		if collectionName != nil{
			dictionary["collectionName"] = collectionName
		}
		if collectionPrice != nil{
			dictionary["collectionPrice"] = collectionPrice
		}
		if collectionViewUrl != nil{
			dictionary["collectionViewUrl"] = collectionViewUrl
		}
		if contentAdvisoryRating != nil{
			dictionary["contentAdvisoryRating"] = contentAdvisoryRating
		}
		if country != nil{
			dictionary["country"] = country
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if discCount != nil{
			dictionary["discCount"] = discCount
		}
		if discNumber != nil{
			dictionary["discNumber"] = discNumber
		}
		if hasITunesExtras != nil{
			dictionary["hasITunesExtras"] = hasITunesExtras
		}
		if isStreamable != nil{
			dictionary["isStreamable"] = isStreamable
		}
		if kind != nil{
			dictionary["kind"] = kind
		}
		if longDescription != nil{
			dictionary["longDescription"] = longDescription
		}
		if previewUrl != nil{
			dictionary["previewUrl"] = previewUrl
		}
		if primaryGenreName != nil{
			dictionary["primaryGenreName"] = primaryGenreName
		}
		if releaseDate != nil{
			dictionary["releaseDate"] = releaseDate
		}
		if shortDescription != nil{
			dictionary["shortDescription"] = shortDescription
		}
		if trackCensoredName != nil{
			dictionary["trackCensoredName"] = trackCensoredName
		}
		if trackCount != nil{
			dictionary["trackCount"] = trackCount
		}
		if trackExplicitness != nil{
			dictionary["trackExplicitness"] = trackExplicitness
		}
		if trackHdPrice != nil{
			dictionary["trackHdPrice"] = trackHdPrice
		}
		if trackHdRentalPrice != nil{
			dictionary["trackHdRentalPrice"] = trackHdRentalPrice
		}
		if trackId != nil{
			dictionary["trackId"] = trackId
		}
		if trackName != nil{
			dictionary["trackName"] = trackName
		}
		if trackNumber != nil{
			dictionary["trackNumber"] = trackNumber
		}
		if trackPrice != nil{
			dictionary["trackPrice"] = trackPrice
		}
		if trackRentalPrice != nil{
			dictionary["trackRentalPrice"] = trackRentalPrice
		}
		if trackTimeMillis != nil{
			dictionary["trackTimeMillis"] = trackTimeMillis
		}
		if trackViewUrl != nil{
			dictionary["trackViewUrl"] = trackViewUrl
		}
		if wrapperType != nil{
			dictionary["wrapperType"] = wrapperType
		}
		return dictionary
	}

}
