// Here's a different take on JSON fixtures: use a string in which you can interpolate values so
// that the tests are more straightforward to read, no myserious values that come from the JSON file
// and you'd have to go back and forth to understand.

// swiftlint:disable:next function_body_length
func launchJSON(
    name: String = "FalconSat",
    id: String = "5eb87cd9ffd86e000604b32a",
    dateUnix: Int = 123456
) -> String {
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
    "date_unix": \(dateUnix),
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

func launchesJSONFixture(
    with launches: [String] = [launchJSON(id: "1"), launchJSON(id: "2")]
) -> String {
    return "[" + launches.joined(separator: ",") + "]"
}

// Keeping it here just in case
// swiftlint:disable line_length
let jsonString = #"""
[
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
        "id": "5eb87cd9ffd86e000604b32a",
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
        "name": "FalconSat",
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
    },
    {
        "auto_update": true,
        "capsules": [],
        "cores": [
            {
                "core": "5e9e289ef35918416a3b2624",
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
        "date_local": "2007-03-21T13:10:00+12:00",
        "date_precision": "hour",
        "date_unix": 1174439400,
        "date_utc": "2007-03-21T01:10:00.000Z",
        "details": "Successful first stage burn and transition to second stage, maximum altitude 289 km, Premature engine shutdown at T+7 min 30 s, Failed to reach orbit, Failed to recover first stage",
        "failures": [
            "harmonic oscillation leading to premature engine shutdown"
        ],
        "fairings": {
            "recovered": false,
            "recovery_attempt": false,
            "reused": false,
            "ships": []
        },
        "flight_number": 2,
        "id": "5eb87cdaffd86e000604b32b",
        "launchpad": "5e9e4502f5090995de566f86",
        "links": {
            "article": "https://www.space.com/3590-spacex-falcon-1-rocket-fails-reach-orbit.html",
            "flickr": {
                "original": [],
                "small": []
            },
            "patch": {
                "large": "https://images2.imgbox.com/be/e7/iNqsqVYM_o.png",
                "small": "https://images2.imgbox.com/4f/e3/I0lkuJ2e_o.png"
            },
            "presskit": null,
            "reddit": {
                "campaign": null,
                "launch": null,
                "media": null,
                "recovery": null
            },
            "webcast": "https://www.youtube.com/watch?v=Lk4zQ2wP-Nc",
            "wikipedia": "https://en.wikipedia.org/wiki/DemoSat",
            "youtube_id": "Lk4zQ2wP-Nc"
        },
        "name": "DemoSat",
        "net": false,
        "payloads": [
            "5eb0e4b6b6c3bb0006eeb1e2"
        ],
        "rocket": "5e9d0d95eda69955f709d1eb",
        "ships": [],
        "static_fire_date_unix": null,
        "static_fire_date_utc": null,
        "success": false,
        "tbd": false,
        "upcoming": false,
        "window": 0
    },
    {
        "auto_update": true,
        "capsules": [],
        "cores": [
            {
                "core": "5e9e289ef3591814873b2625",
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
        "date_local": "2008-08-02T15:34:00+12:00",
        "date_precision": "hour",
        "date_unix": 1217648040,
        "date_utc": "2008-08-02T03:34:00.000Z",
        "details": "Residual stage 1 thrust led to collision between stage 1 and stage 2",
        "failures": [
            "residual stage-1 thrust led to collision between stage 1 and stage 2"
        ],
        "fairings": {
            "recovered": false,
            "recovery_attempt": false,
            "reused": false,
            "ships": []
        },
        "flight_number": 3,
        "id": "5eb87cdbffd86e000604b32c",
        "launchpad": "5e9e4502f5090995de566f86",
        "links": {
            "article": "http://www.spacex.com/news/2013/02/11/falcon-1-flight-3-mission-summary",
            "flickr": {
                "original": [],
                "small": []
            },
            "patch": {
                "large": "https://images2.imgbox.com/4b/bd/d8UxLh4q_o.png",
                "small": "https://images2.imgbox.com/3d/86/cnu0pan8_o.png"
            },
            "presskit": null,
            "reddit": {
                "campaign": null,
                "launch": null,
                "media": null,
                "recovery": null
            },
            "webcast": "https://www.youtube.com/watch?v=v0w9p3U8860",
            "wikipedia": "https://en.wikipedia.org/wiki/Trailblazer_(satellite)",
            "youtube_id": "v0w9p3U8860"
        },
        "name": "Trailblazer",
        "net": false,
        "payloads": [
            "5eb0e4b6b6c3bb0006eeb1e3",
            "5eb0e4b6b6c3bb0006eeb1e4"
        ],
        "rocket": "5e9d0d95eda69955f709d1eb",
        "ships": [],
        "static_fire_date_unix": null,
        "static_fire_date_utc": null,
        "success": false,
        "tbd": false,
        "upcoming": false,
        "window": 0
    }
]
"""#
// swiftlint:enable line_length
