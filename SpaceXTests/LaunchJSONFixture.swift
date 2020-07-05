// Here's a different take on JSON fixtures: use a string in which you can interpolate values so
// that the tests are more straightforward to read, no myserious values that come from the JSON file
// and you'd have to go back and forth to understand.

// swiftlint:disable:next function_body_length
func launchJSON(name: String = "FalconSat", id: String = "5eb87cd9ffd86e000604b32a") -> String {
    // This is the very first SpaceX launch, from https://api.spacexdata.com/v4/launches/past.
    """
{
    "auto_update": true,
    "capsules": [],
    "cores": [
        {
            "core": "5e9e289df35918033d3b2623",
            "flight": 1,
            "gridfins": false,
            "landing_attempt": false,
            "landing_success": null,
            "landing_type": null,
            "landpad": null,
            "legs": false,
            "reused": false
        }
    ],
    "crew": [],
    "date_local": "2006-03-25T10:30:00+12:00",
    "date_precision": "hour",
    "date_unix": 1143239400,
    "date_utc": "2006-03-24T22:30:00.000Z",
    "details": "Engine failure at 33 seconds and loss of vehicle",
    "failures": [
        "merlin engine failure"
    ],
    "fairings": {
        "recovered": false,
        "recovery_attempt": false,
        "reused": false,
        "ships": []
    },
    "flight_number": 1,
    "id": "\(id)",
    "launchpad": "5e9e4502f5090995de566f86",
    "links": {
        "article": "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html",
        "flickr": {
            "original": [],
            "small": []
        },
        "patch": {
            "large": "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
            "small": "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png"
        },
        "presskit": null,
        "reddit": {
            "campaign": null,
            "launch": null,
            "media": null,
            "recovery": null
        },
        "webcast": "https://www.youtube.com/watch?v=0a_00nJ_Y88",
        "wikipedia": "https://en.wikipedia.org/wiki/DemoSat",
        "youtube_id": "0a_00nJ_Y88"
    },
    "name": "\(name)",
    "net": false,
    "payloads": [
        "5eb0e4b5b6c3bb0006eeb1e1"
    ],
    "rocket": "5e9d0d95eda69955f709d1eb",
    "ships": [],
    "static_fire_date_unix": 1142553600,
    "static_fire_date_utc": "2006-03-17T00:00:00.000Z",
    "success": false,
    "tbd": false,
    "upcoming": false,
    "window": 0
}
"""
}
